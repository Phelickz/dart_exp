part of loggy;

/// Whether to allow fine-grain logging and configuration of loggers in a
/// hierarchy.
///
/// When false, all hierarchical logging instead is merged in the root logger.
bool hierarchicalLoggingEnabled = false;

/// The default [LogLevel].
const defaultLevel = LogOptions(LogLevel.all);

/// Use a [ExpressLoggy] to log debug messages.
///
/// [ExpressLoggy]s are named using a hierarchical dot-separated name convention,
/// and their types are used to [_whitelist] or [_blacklist] specific logger types.
/// ExpressLoggy can be any type so end user can have as many or as little different [ExpressLoggy]
/// types as they want.
class ExpressLoggy<T extends ExpressLoggyType> {
  /// Singleton constructor. Calling `new ExpressLoggy(name)` will return the same
  /// actual instance whenever it is called with the same string name.
  factory ExpressLoggy(String name) =>
      _loggers.putIfAbsent(name, () => ExpressLoggy<T>._named(name)) as ExpressLoggy<T>;

  /// Creates a new detached [ExpressLoggy].
  ///
  /// Returns a new [ExpressLoggy] instance (unlike `new ExpressLoggy`, which returns a
  /// [ExpressLoggy] singleton), which doesn't have any parent or children,
  /// and is not a part of the global hierarchical loggers structure.
  ///
  /// It can be useful when you just need a local short-living logger,
  /// which you'd like to be garbage-collected later.
  factory ExpressLoggy.detached(String name) =>
      ExpressLoggy<T>._internal(name, null, <String, ExpressLoggy>{});

  factory ExpressLoggy._named(String name) {
    if (name.startsWith('.')) {
      throw ArgumentError("name shouldn't start with a '.'");
    }
    // Split hierarchical names (separated with '.').
    final dot = name.lastIndexOf('.');
    ExpressLoggy? _parent;
    String thisName;
    if (dot == -1) {
      if (name != '') {
        _parent = ExpressLoggy('');
      }

      thisName = name;
    } else {
      _parent = ExpressLoggy(name.substring(0, dot));
      thisName = name.substring(dot + 1);
    }
    return ExpressLoggy<T>._internal(thisName, _parent, <String, ExpressLoggy>{});
  }

  ExpressLoggy._internal(this.name, this._parent, Map<String, ExpressLoggy> children)
      : _children = children,
        children = UnmodifiableMapView(children) {
    if (_parent == null) {
      _level = defaultLevel;
    } else {
      _parent!._children[name] = this;
    }
  }

  /// Simple name of this logger.
  final String name;

  /// The full name of this logger, which includes the parent's full name.
  String get fullName => (_parent == null || _parent!.name == '')
      ? name
      : '${_parent!.fullName}.$name';

  /// Parent of this logger in the hierarchy of loggers.
  final ExpressLoggy? _parent;

  /// Logging [LogLevel] used for entries generated on this logger.
  LogOptions _level = defaultLevel;

  /// List of [ExpressLoggyFilters] to be used when determining what to log
  List<ExpressLoggyFilter> _filters = <ExpressLoggyFilter>[];

  final Map<String, ExpressLoggy> _children;

  /// Children in the hierarchy of loggers, indexed by their simple names.
  final Map<String, ExpressLoggy> children;

  /// Controller used to notify when log entries are added to this logger.
  StreamController<LogRecord>? _controller;

  LogPrinter? _printer;

  ExpressLoggy? get parent {
    if (_parent != null) {
      return _parent;
    }

    return this;
  }

  static LogPrinter? get currentPrinter => _root._printer;

  /// Set custom printer on logger.
  set printer(LogPrinter? printer) {
    if (printer == null) {
      return;
    }

    clearListeners();

    _printer = printer;
    parent!._logStream.listen(_printer!.onLog);
  }

  /// Effective level considering the levels established in this logger's
  /// parents (when [hierarchicalLoggingEnabled] is true).
  LogOptions get level {
    LogOptions _effectiveLevel;

    if (_parent == null) {
      _effectiveLevel = _level;
    } else if (!hierarchicalLoggingEnabled) {
      _effectiveLevel = _root._level;
    } else {
      _effectiveLevel = _level;
    }

    return _effectiveLevel;
  }

  /// Override the level for this particular [ExpressLoggy] and its children.
  set level(LogOptions value) {
    if (!hierarchicalLoggingEnabled && _parent != null) {
      throw UnsupportedError(
          'Please set "hierarchicalLoggingEnabled" to true if you want to '
          'change the level on a non-root logger.');
    }
    _level = value;
  }

  /// Put logger types on whitelist.
  /// This will only send logs from passed types
  set filters(List<ExpressLoggyFilter> filters) {
    _filters = filters;
  }

  /// Connect to logger stream
  Stream<LogRecord> get _logStream => _getStream();

  void clearListeners() {
    if (hierarchicalLoggingEnabled || _parent == null) {
      if (_controller != null) {
        _controller!.close();
        _controller = null;
      }
    } else {
      _root.clearListeners();
    }
  }

  /// Gets logger root type, in case this is a named sub logger
  /// it has to follow same filtering as it's parent logger.
  ///
  /// This does not include [_root] as that logger doesn't have a Type
  Type _getRootType() {
    if (_parent != null && _parent != _root) {
      return _parent!._getRootType();
    }

    return T;
  }

  /// Return bool value whether this log should be shown or not
  bool _isLoggable(LogLevel value) {
    // Go through all filters passed and figure out if log should be shown
    bool _foldFilters(List<ExpressLoggyFilter> filters) => filters.fold(
        true,
        (shouldLog, filter) =>
            filter.shouldLog(value, _getRootType()) && shouldLog);

    if (value.priority >= level.logLevel.priority) {
      return _foldFilters(_parent == null ? _filters : _root._filters);
    }

    return false;
  }

  /// Adds a log record for a [message] at a particular [logLevel] if
  /// `isLoggable(logLevel)` is true.
  ///
  /// Use this method to create log entries for user-defined levels. To record a
  /// message at a predefined level (e.g. [LogLevel.info], [LogLevel.warning], etc)
  /// you can use their specialized methods instead (e.g. [info], [warning],
  /// etc).
  ///
  /// If [message] is a [Function], it will be lazy evaluated. Additionally, if
  /// [message] or its evaluated value is not a [String], then 'toString()' will
  /// be called on the object and the result will be logged. The log record will
  /// contain a field holding the original object.
  ///
  /// The log record will also contain a field for the zone in which this call
  /// was made. This can be advantageous if a log listener wants to handler
  /// records of different zones differently (e.g. group log records by HTTP
  /// request if each HTTP request handler runs in it's own zone).
  ///
  /// Caller frame will be null unless [LogOptions.includeCallerInfo] was set to true.
  void log(LogLevel logLevel, dynamic message,
      [Object? error, StackTrace? stackTrace, Zone? zone, Frame? callerFrame]) {
    Object? object;
    if (_isLoggable(logLevel)) {
      if (message is Function) {
        message = message();
      }

      String msg;
      if (message is String) {
        msg = message;
      } else {
        msg = message.toString();
        object = message;
      }

      if (stackTrace == null &&
          logLevel.priority >= level.stackTraceLevel.priority) {
        stackTrace = StackTrace.current;
        error ??= 'autogenerated stack trace for $logLevel $msg';
      }

      zone ??= Zone.current;
      callerFrame ??= _getCallerFrame();

      final record = LogRecord(logLevel, msg, fullName, error, stackTrace, zone,
          object, callerFrame);

      if (_parent == null) {
        _publish(record);
      } else if (!hierarchicalLoggingEnabled) {
        _root._publish(record);
      } else {
        ExpressLoggy<dynamic>? target = this;
        while (target != null) {
          target._publish(record);
          target = target._parent;
        }
      }
    }
  }

  Frame? _getCallerFrame() {
    if (!level.includeCallerInfo) {
      return null;
    }

    const _level = 3;
    // Expensive
    final frames = Trace.current(_level).frames;
    return frames.isEmpty ? null : frames.first;
  }

  void debug(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(LogLevel.debug, message, error, stackTrace);
  void info(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(LogLevel.info, message, error, stackTrace);
  void warning(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(LogLevel.warning, message, error, stackTrace);
  void error(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      log(LogLevel.error, message, error, stackTrace);

  Stream<LogRecord> _getStream() {
    if (hierarchicalLoggingEnabled || _parent == null) {
      _controller ??= StreamController<LogRecord>.broadcast(sync: true);
      return _controller!.stream;
    } else {
      return _root._getStream();
    }
  }

  void _publish(LogRecord record) {
    if (_controller != null) {
      _controller!.add(record);
    }
  }

  static final ExpressLoggy _root = ExpressLoggy('');
  static final Map<String, ExpressLoggy> _loggers = <String, ExpressLoggy>{};

  static void initExpressLoggy({
    LogPrinter logPrinter = const DefaultPrinter(),
    LogOptions logOptions = defaultLevel,
    List<ExpressLoggyFilter> filters = const [],
    bool hierarchicalLogging = false,
  }) {
    ExpressLoggy._root.level = logOptions;
    ExpressLoggy._root.filters = filters;
    ExpressLoggy._root.printer = logPrinter;
    hierarchicalLoggingEnabled = hierarchicalLogging;
  }
}
