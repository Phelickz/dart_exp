part of loggy;

/// Filter for loggy, everytime new log is added, [ExpressLoggy] will go thorough all the filters
/// and if any of them is false, that log will not be displayed.
abstract class ExpressLoggyFilter {
  const ExpressLoggyFilter();

  bool shouldLog(LogLevel level, Type type);
}
