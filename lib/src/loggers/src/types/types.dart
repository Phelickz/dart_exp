part of loggy;

mixin NetworkExpressLoggy implements ExpressLoggyType {
  @override
  ExpressLoggy<NetworkExpressLoggy> get loggy =>
      ExpressLoggy<NetworkExpressLoggy>('Network ExpressLoggy - ${runtimeType.toString()}');
}

mixin UiExpressLoggy implements ExpressLoggyType {
  @override
  ExpressLoggy<UiExpressLoggy> get loggy =>
      ExpressLoggy<UiExpressLoggy>('UI ExpressLoggy - ${runtimeType.toString()}');
}

mixin ExpressLogs implements ExpressLoggyType {
  @override
  ExpressLoggy<ExpressLogs> get loggy =>
      ExpressLoggy<ExpressLogs>('Express Logs - $runtimeType');
}
