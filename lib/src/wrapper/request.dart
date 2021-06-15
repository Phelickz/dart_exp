// import 'package:dart2_constant/html.dart';

import 'dart:async';
import 'package:express_dt/express_dt.dart';
import 'package:express_dt/src/session/session.dart';
import 'package:universal_io/io.dart';
import 'dart:typed_data';

import 'package:express_dt/src/wrapper/file.dart';

class ExpressRequest {
  SessionManager? sessionManager;
  StreamController? stream;
  HttpRequest? req;

  ExpressResponse? response;

  // HttpSession? sessions;
  Map<dynamic, dynamic> reqBody = {};

  Map<String, ExpressFile> files = {};

  List? currentExceptionList;

  Session? _session;

  Map<dynamic, dynamic> params = {};

  ExpressRequest(HttpRequest req, {SessionManager? manager}) {
    this.req = req;
    this.sessionManager = manager;
  }

  Map get body => reqBody;

  Uri get url => req!.uri;

  Map get query => req!.uri.queryParameters;

  String get path => req!.uri.path;

  Session get parsedSession => _session!;

  HttpHeaders get headers => req!.headers;

  String get type => req!.headers.contentType!.value;

 /// Returns cookies set in HTTP request.
  Map<String, Cookie> get cookies => _cookies ??= _parseCookies();

  Map<String, Cookie>? _cookies;

  Map<String, Cookie> _parseCookies() {
    final ret = <String, Cookie>{};
    for (Cookie cookie in req!.cookies) {
      ret[cookie.name] = cookie;
    }
    return ret;
  }

    /// Does the session need update?
  bool get sessionNeedsUpdate => _session != null && _session!.needsUpdate;

  /// The session for the given request.
  ///
  /// Example:
  ///
  ///     server.get('/api/set/:item', (ctx) async {
  ///       final Session session = await ctx.req.session;
  ///       session['item'] = ctx.pathParams.item;
  ///       // ...
  ///     });

  Future<Session> get session async =>
      _session ??= await sessionManager!.parse(this);

  @override
  Future<bool> any(bool Function(Uint8List element) element) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> asBroadcastStream(
      {void Function(StreamSubscription<Uint8List>)? onCancel,
      void Function(StreamSubscription<Uint8List>)? onListen}) {
    // TODO: implement asBroadcastStream
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(Uint8List) element) {
    // Tevent) event) ) {
    // TODO: implement asyncExpand
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(Uint8List) element) {
    // TOevent) event) ) {
    // TODO: implement asyncMap
    throw UnimplementedError();
  }

  @override
  Stream<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  // TODO: implement certificate
  X509Certificate? get certificate => req!.certificate;

  @override
  // TODO: implement connectionInfo
  HttpConnectionInfo? get connectionInfo => req!.connectionInfo;

  @override
  Future<bool> contains(Object? needle) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  // TODO: implement contentLength
  int get contentLength => req!.contentLength;

  // @override
  // // TODO: implement cookies
  // List<Cookie> get cookies => req!.cookies;

  @override
  Stream<Uint8List> distinct([bool Function(Uint8List, Uint8List)? element]) {
    // TODO: implement distinct
    throw UnimplementedError();
  }

  @override
  Future<E> drain<E>([E? futureValue]) {
    // TODO: implement drain
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  Future<bool> every(bool Function(Uint8List) element) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(Uint8List) element) {
    // TOelement) element) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  // TODO: implement first
  Future<Uint8List> get first => req!.first;

  @override
  Future<Uint8List> firstWhere(bool Function(Uint8List) element,
      {Uint8List Function()? orElse}) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  Future<S> fold<S>(S, S Function(S, Uint8List) element) {
    // TODOelement) element) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Future forEach(void Function(Uint8List) element) {
    // TODO: implement forEach
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> handleError(Function element,
      {bool Function(dynamic)? test}) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  // @override
  // // TODO: implement headers
  // HttpHeaders get headers => throw UnimplementedError();

  @override
  // TODO: implement isBroadcast
  bool get isBroadcast => req!.isBroadcast;

  @override
  // TODO: implement isEmpty
  Future<bool> get isEmpty => req!.isEmpty;

  @override
  Future<String> join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Future<Uint8List> get last => req!.last;

  @override
  Future<Uint8List> lastWhere(bool Function(Uint8List) element,
      {Uint8List Function()? orElse}) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  // TODO: implement length
  Future<int> get length => req!.length;

  @override
  StreamSubscription<Uint8List> listen(void Function(Uint8List)? element,
      {bool? cancelOnError, void Function()? onDone, Function? onError}) {
    // TODO: implement listen
    // throw UnimplementedError();
    throw '';
  }

  @override
  Stream<S> map<S>(S Function(Uint8List) element) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  // TODO: implement method
  String get method => req!.method;

  @override
  // TODO: implement persistentConnection
  bool get persistentConnection => req!.persistentConnection;

  @override
  Future pipe(StreamConsumer<Uint8List> streamConsumer) {
    // TODO: implement pipe
    throw UnimplementedError();
  }

  @override
  // TODO: implement protocolVersion
  String get protocolVersion => req!.protocolVersion;

  @override
  Future<Uint8List> reduce(Uint8List Function(Uint8List, Uint8List) element) {
    // previous, Uint8List element) previou) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement requestedUri
  Uri get requestedUri => req!.requestedUri;

  // @override
  // // TODO: implement response
  // HttpResponse get response => req!.response;

  // @override
  // // TODO: implement session
  // HttpSession get session => throw UnimplementedError();

  @override
  // TODO: implement single
  Future<Uint8List> get single => req!.single;

  @override
  Future<Uint8List> singleWhere(bool Function(Uint8List) element,
      {Uint8List Function()? orElse}) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> skipWhile(bool Function(Uint8List) element) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> takeWhile(bool Function(Uint8List) element) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> timeout(Duration timeout,
      {void Function(EventSink<Uint8List>)? onTimeout}) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<List<Uint8List>> toList() {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Future<Set<Uint8List>> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<Uint8List, S> streamTransformer) {
    // print('Here');
    // throw UnimplementedError();
    return streamTransformer.bind(this.req!);
  }

  @override
  // TODO: implement uri
  Uri get uri => uri;

  @override
  Stream<Uint8List> where(bool Function(Uint8List event) event) {
    // TODO: implement where
    throw UnimplementedError();
  }
}
