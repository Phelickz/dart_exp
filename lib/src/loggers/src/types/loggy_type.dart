part of loggy;

/// Different logger types must be mixins and they have to implement [ExpressLoggyType]
/// This will make sure that each mixin is using it's own [ExpressLoggy] and that will be usefull
/// when dictating what we want to show
abstract class ExpressLoggyType {
  ExpressLoggy get loggy;
}

extension ExpressLoggySpawner on ExpressLoggyType {
  ExpressLoggy newExpressLoggy(String name) => ExpressLoggy('${loggy.fullName}.$name');
  ExpressLoggy detachedExpressLoggy(String name, {LogPrinter? logPrinter}) => ExpressLoggy.detached(name)..printer = logPrinter;
}
