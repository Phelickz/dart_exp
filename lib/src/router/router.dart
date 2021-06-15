// import 'package:express_dt/express_dt.dart';
import 'package:express_dt/src/model/get.dart';
// import 'package:sevr/src/serv_request_response_wrapper/serv_request_wrapper.dart';

class Router {
  var gets = ExpressMethod(route: '').callback;

  var posts = ExpressMethod(route: '').callback;

  var patchs = ExpressMethod(route: '').callback;

  var puts = ExpressMethod(route: '').callback;

  var deletes = ExpressMethod(route: '').callback;

  var copys = ExpressMethod(route: '').callback;

  var heads = ExpressMethod(route: '').callback;

  var optionss = ExpressMethod(route: '').callback;

  var links = ExpressMethod(route: '').callback;

  var unlinks = ExpressMethod(route: '').callback;

  var purges = ExpressMethod(route: '').callback;

  var locks = ExpressMethod(route: '').callback;

  var unlocks = ExpressMethod(route: '').callback;

  var propfinds = ExpressMethod(route: '').callback;

  var views = ExpressMethod(route: '').callback;

  // List<String> getRoutes = [];

  dynamic get(ExpressMethod routeData) {
    gets = routeData.callback;
  }

  dynamic post(ExpressMethod routeData) {
    posts = routeData.callback;
  }

  dynamic patch(ExpressMethod routeData) {
    patchs = routeData.callback;
  }

  dynamic put(ExpressMethod routeData) {
    puts = routeData.callback;
  }

  dynamic delete(ExpressMethod routeData) {
    deletes = routeData.callback;
  }

  dynamic copy(ExpressMethod routeData) {
    copys = routeData.callback;
  }

  dynamic head(ExpressMethod routeData) {
    heads = routeData.callback;
  }

  dynamic options(ExpressMethod routeData) {
    optionss = routeData.callback;
  }

  dynamic link(ExpressMethod routeData) {
    links = routeData.callback;
  }

  dynamic unlink(ExpressMethod routeData) {
    unlinks = routeData.callback;
  }

  dynamic purge(ExpressMethod routeData) {
    purges = routeData.callback;
  }

  dynamic lock(ExpressMethod routeData) {
    locks = routeData.callback;
  }

  dynamic unlock(ExpressMethod routeData) {
    unlocks = routeData.callback;
  }

  dynamic propfind(ExpressMethod routeData) {
    propfinds = routeData.callback;
  }

  dynamic view(ExpressMethod routeData) {
    views = routeData.callback;
  }

  // dynamic get(String route,
  //     List<Function(ExpressRequest req, ExpressResponse res)> callbacks) {
  //   gets[route] = callbacks;
  // }

  void join(Router rter) {
    gets.addAll(rter.gets);
    posts.addAll(rter.posts);
    patchs.addAll(rter.patchs);
    puts.addAll(rter.puts);
    deletes.addAll(rter.deletes);
    copys.addAll(rter.copys);
    heads.addAll(rter.heads);
    optionss.addAll(rter.optionss);
    links.addAll(rter.links);
    unlinks.addAll(rter.unlinks);
    purges.addAll(rter.purges);
    locks.addAll(rter.locks);
    unlocks.addAll(rter.unlocks);
    propfinds.addAll(rter.propfinds);
    views.addAll(rter.views);
  }
}
