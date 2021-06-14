// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:express_dt/src/http_server/src/http_multipart_form_data.dart';
// // import 'package:get_server/get_server.dart' as gt;

// // import 'package:dart2_constant/io.dart';
// import 'package:express_dt/src/contenttype/dir.dart';
// import 'package:express_dt/src/contenttype/enum.dart';
// import 'package:express_dt/src/loggers/loggy.dart';
// import 'package:express_dt/src/mime/mime_src/mime_multipart_transformer.dart';
// import 'package:express_dt/src/mime/mime_src/mime_shared.dart';
// // import 'package:express_dt/src/session/sessions.dart';
// import 'package:express_dt/src/wrapper/cors.dart';
// import 'package:express_dt/src/wrapper/file.dart';
// import 'package:express_dt/src/wrapper/request.dart';
// import 'package:express_dt/src/wrapper/response.dart';

// import 'package:pedantic/pedantic.dart';

// import 'build.dart';
// import 'contenttype/contentTypes.dart';
// import 'logs/log.dart';
// import 'model/get.dart';
// import 'router/router.dart';

// class Express implements HttpServer {
//   Future<bool> any(bool Function(HttpRequest element) element) {
//     // TODO: implement any
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> asBroadcastStream({void Function(StreamSubscription<HttpRequest>)? onCancel, void Function(StreamSubscription<HttpRequest>)? onListen}) {
//     // TODO: implement asBroadcastStream
//     throw UnimplementedError();
//   }

//   @override
//   Stream<E> asyncExpand<E>(Stream<E>? Function(HttpRequest) element) {
//     // Tevent) event) ) {
//     // TODO: implement asyncExpand
//     throw UnimplementedError();
//   }

//   @override
//   Stream<E> asyncMap<E>(FutureOr<E> Function(HttpRequest) element) {
//     // TOevent) event) ) {
//     // TODO: implement asyncMap
//     throw UnimplementedError();
//   }

//   @override
//   Stream<R> cast<R>() {
//     // TODO: implement cast
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement certificate
//   X509Certificate? get certificate => throw UnimplementedError();

//   @override
//   // TODO: implement connectionInfo
//   HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

//   @override
//   Future<bool> contains(Object? needle) {
//     // TODO: implement contains
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement contentLength
//   int get contentLength => throw UnimplementedError();

//   @override
//   // TODO: implement cookies
//   List<Cookie> get cookies => throw UnimplementedError();

//   @override
//   Stream<HttpRequest> distinct([bool Function(HttpRequest, HttpRequest)?element]) {
//     // TODO: implement distinct
//     throw UnimplementedError();
//   }

//   @override
//   Future<E> drain<E>([E? futureValue]) {
//     // TODO: implement drain
//     throw UnimplementedError();
//   }

//   @override
//   Future<HttpRequest> elementAt(int index) {
//     // TODO: implement elementAt
//     throw UnimplementedError();
//   }

//   @override
//   Future<bool> every(bool Function(HttpRequest) element) {
//     // TODO: implement every
//     throw UnimplementedError();
//   }

//   @override
//   Stream<S> expand<S>(Iterable<S> Function(HttpRequest) element) {
//     // TOelement) element) {
//     // TODO: implement expand
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement first
//   Future<HttpRequest> get first => throw UnimplementedError();

//   @override
//   Future<HttpRequest> firstWhere(bool Function(HttpRequest) element, {HttpRequest Function()? orElse}) {
//     // TODO: implement firstWhere
//     throw UnimplementedError();
//   }

//   @override
//   Future<S> fold<S>(S, S Function(S, HttpRequest) element) {
//     // TODOelement) element) {
//     // TODO: implement fold
//     throw UnimplementedError();
//   }

//   @override
//   Future forEach(void Function(HttpRequest) element) {
//     // TODO: implement forEach
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> handleError(Function element, {bool Function(dynamic)? test}) {
//     // TODO: implement handleError
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement headers
//   HttpHeaders get headers => throw UnimplementedError();

//   @override
//   // TODO: implement isBroadcast
//   bool get isBroadcast => throw UnimplementedError();

//   @override
//   // TODO: implement isEmpty
//   Future<bool> get isEmpty => throw UnimplementedError();

//   @override
//   Future<String> join([String separator = ""]) {
//     // TODO: implement join
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement last
//   Future<HttpRequest> get last => throw UnimplementedError();

//   @override
//   Future<HttpRequest> lastWhere(bool Function(HttpRequest) element, {HttpRequest Function()? orElse}) {
//     // TODO: implement lastWhere
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement length
//   Future<int> get length => throw UnimplementedError();

//   @override
//   StreamSubscription<HttpRequest> listen(void Function(HttpRequest)? element, {bool? cancelOnError, void Function()? onDone, Function? onError}) {
//     // TODO: implement listen
//     throw UnimplementedError();
//   }

//   @override
//   Stream<S> map<S>(S Function(HttpRequest) element) {
//     // TODO: implement map
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement method
//   String get method => throw UnimplementedError();

//   @override
//   // TODO: implement persistentConnection
//   bool get persistentConnection => throw UnimplementedError();

//   @override
//   Future pipe(StreamConsumer<HttpRequest> streamConsumer) {
//     // TODO: implement pipe
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement protocolVersion
//   String get protocolVersion => throw UnimplementedError();

//   @override
//   Future<HttpRequest> reduce(HttpRequest Function(HttpRequest, HttpRequest)element) {
//     // previous, HttpRequest element) previou) {
//     // TODO: implement reduce
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement requestedUri
//   Uri get requestedUri => throw UnimplementedError();

//   @override
//   // TODO: implement response
//   // HttpResponse get response => throw UnimplementedError();

//   @override
//   // TODO: implement session
//   HttpSession get session => throw UnimplementedError();

//   @override
//   // TODO: implement single
//   Future<HttpRequest> get single => throw UnimplementedError();

//   @override
//   Future<HttpRequest> singleWhere(bool Function(HttpRequest) element, {HttpRequest Function()? orElse}) {
//     // TODO: implement singleWhere
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> skip(int count) {
//     // TODO: implement skip
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> skipWhile(bool Function(HttpRequest) element) {
//     // TODO: implement skipWhile
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> take(int count) {
//     // TODO: implement take
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> takeWhile(bool Function(HttpRequest) element) {
//     // TODO: implement takeWhile
//     throw UnimplementedError();
//   }

//   @override
//   Stream<HttpRequest> timeout(Duration timeout, {void Function(EventSink<HttpRequest>)? onTimeout}) {
//     // TODO: implement timeout
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<HttpRequest>> toList() {
//     // TODO: implement toList
//     throw UnimplementedError();
//   }

//   @override
//   Future<Set<HttpRequest>> toSet() {
//     // TODO: implement toSet
//     throw UnimplementedError();
//   }

//   @override
//   Stream<S> transform<S>(StreamTransformer<HttpRequest, S> streamTransformer) {
//     // TODO: implement transform
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement uri
//   Uri get uri => throw UnimplementedError();

//   @override
//   Stream<HttpRequest> where(bool Function(HttpRequest event) event) {
//     // TODO: implement where
//     throw UnimplementedError();
//   }
//   final lgr = ExpressLoggy.initExpressLoggy(
//     logPrinter: PrettyPrinter(showColors: true),
//     logOptions: const LogOptions(
//       LogLevel.all,
//       stackTraceLevel: LogLevel.error,
//     ),
//     filters: [
//       // BlacklistFilter([BlacklistedExpressLoggy]),
//     ],
//   );

//   factory Express() {
//     return _express;
//   }

//   static final Express _express = Express._internal();

//   Express._internal();

//   List<ExpressDir> expressDirs = [];

//   HttpServer? client;

//   static ExpressDir static(String dir) {
//     return ExpressDir(dir);
//   }

//   Router router = Router();
//   Cors? cors;
//   // Session? session;
//   int? port;
//   var host;
//   String response = '';

//   void onClose() async {
//     if (client != null) {
//       await client!.close(force: true);
//     }
//   }

//   void onRestart() async {
//     print('Server is restarting');
//     onClose();
//   }

//   dynamic stream(int port,
//       {Function? callback,
//       SecurityContext? context,
//       String? messageReturn,
//       String? address,
//       Function(Object e, StackTrace c)? errorHandler}) async {
//     await runZonedGuarded(() async {
//       Message().logDebug('Starting server..');
//       this.response = response;
//       if (callback != null) {
//         callback();
//       }
//       if (context == null) {
//         client = await HttpServer.bind(
//             address ?? InternetAddress.loopbackIPv4, port);
//       } else {
//         client = await HttpServer.bindSecure(
//             InternetAddress.loopbackIPv4, port, context);
//       }

//       this.port = port;
//       host = InternetAddress.loopbackIPv4;
//       Message().logDebug(
//           'Server is running $host and $port at http://${host.address}:$port');

//       await for (var request in client!) {
//         onCall(request);
//       }
//     }, (Object error, StackTrace stack) async {
//       if (errorHandler == null) {
//         Message().logError(error.toString());
//         // throw error;
//       } else {
//         throw errorHandler;
//       }
//     });
//   }

//   dynamic onCall(HttpRequest request) async {
//     request.session.addAll({"state": "sessionId"});
//     var req = ExpressRequest(request);
//     var res = ExpressResponse(request);

//     var contentType = req.headers.contentType.toString();
//     var jsonData = {};
//     dynamic downloadData = <int>[];
//     // List<dynamic> tempOnData;
//     // tempOnData = [];

//     // if (contentType.contains('multipart/form-data')) {
//     //   contentType = 'multipart/form-data';
//     // }
//     // print(request);
//     // print('ggfc');
//     // _handleRequests(req, res,'GET');
//     // return;

//     if (cors != null) {
//       res.set('Access-Control-Allow-Origin', cors!.allowed_origins.join(' | '));
//       res.set('Access-Control-Allow-Headers', 'Content-Type');
//     }

//     switch (expressContent(contentType)) {
//       case ExpressContentType.ApplicationJson:
//         StreamSubscription? _sub;
//         _sub = request.listen(
//           (Uint8List onData) {
//             downloadData.addAll(onData);
//           },
//           onDone: () {
//             try {
//               var s = String.fromCharCodes(downloadData);
//               if (s.isNotEmpty) {
//                 jsonData.addAll(json.decode(s));
//                 req.reqBody = jsonData.cast<String, dynamic>();
//               }
//               _sub!.cancel();
//             } catch (e, stacktrace) {
//               req.currentExceptionList = [e, stacktrace];
//               rethrow;
//             }
//             _handleRequests(req, res, request.method);
//           },
//         );

//         break;

//       case ExpressContentType.MultipartFormData:
//         var boundary = request.headers.contentType!.parameters['boundary'];
//         var fileKeys = [];

//         request.transform(MimeMultipartTransformer(boundary!)).listen(
//             (MimeMultipart onData) async {
//           var formDataObject = HttpMultipartFormData.parse(onData);
//           if (formDataObject.isBinary ||
//               formDataObject.contentDisposition.parameters
//                   .containsKey('filename')) {
//             // print('isBinary');
//             // print('${formDataObject.contentDisposition.parameters}');
//             if (!fileKeys.contains(
//                 formDataObject.contentDisposition.parameters['name'])) {
//               fileKeys
//                   .add(formDataObject.contentDisposition.parameters['name']);
//               var _fileStreamController = StreamController();
//               var requestFileObject = ExpressFile(
//                   formDataObject.contentDisposition.parameters['name'],
//                   formDataObject.contentDisposition.parameters['filename'],
//                   _fileStreamController);
//               req.files[formDataObject.contentDisposition.parameters['name']!] =
//                   requestFileObject;
//               //was not here before
//               // _fileStreamController.close();
//             }

//             StreamController _fcont;
//             _fcont = req
//                 .files[formDataObject.contentDisposition.parameters['name']]!
//                 .streamController!;

//             unawaited(
//               _fcont.sink.addStream(formDataObject).then(
//                 (dynamic c) async {
//                   return _fcont.close();
//                 },
//               ),
//             );
//           } else {
//             // formDataObject.listen((onData) {
//             jsonData.addAll({
//               formDataObject.contentDisposition.parameters['name']:
//                   await formDataObject.join()
//             });
//             // print(':;;;;;;;;;;;');
//             req.reqBody = jsonData;
//             // print(jsonData);
//             // });
//           }
//         }, onDone: () {});
//         Future.delayed(Duration.zero, () {
//           _handleRequests(req, res, request.method);
//         });
//         break;

//       case ExpressContentType.ApplicationFormUrlEncoded:
//         // get data from form
//         var body = await request
//             .transform(utf8.decoder.cast<Uint8List, dynamic>())
//             .join();

//         Map<String, dynamic> result;
//         result = {};

//         buildMapFromUri(result, body);

//         req.reqBody = result;

//         Future.delayed(Duration.zero, () {
//           _handleRequests(req, res, request.method);
//         });
//         break;

//       case ExpressContentType.TextHtml:
//         request.listen((onData) {
//           // print('On data');
//           // print(String.fromCharCodes(onData));
//         });
//         // request.listen((onData) {
//         //   print(String.fromCharCodes(onData));
//         // });
//         // print('bro html');

//         Future.delayed(Duration.zero, () {
//           _handleRequests(req, res, request.method);
//         });
//         break;

//       default:
//         Future.delayed(Duration.zero, () {
//           _handleRequests(req, res, request.method);
//         });
//         break;
//     }
//   }

//   Map get getAllRoutes {
//     return {
//       // 'GET': router.getTests,
//       'GET': router.gets,
//       'POST': router.posts,
//       'PATCH': router.patchs,
//       'PUT': router.puts,
//       'DELETE': router.deletes,
//       'COPY': router.copys,
//       'HEAD': router.heads,
//       'OPTIONS': router.optionss,
//       'LINK': router.links,
//       'UNLINK': router.unlinks,
//       'PURGE': router.purges,
//       'LOCK': router.locks,
//       'UNLOCK': router.unlocks,
//       'PROPFIND': router.propfinds,
//       'VIEW': router.views
//     };
//   }

//   Map<String, dynamic>? getRouteParams(String route, Map<String, List> query) {
//     Map<String, dynamic> compareMap;
//     compareMap = {'params': {}, 'route': null};
//     String matched;
//     matched = query.keys.firstWhere((String key) {
//       List<String> routeArr;
//       routeArr = route.split('/');
//       List<String> keyArr;
//       keyArr = key.split('/');
//       if (routeArr.length != keyArr.length) return false;
//       for (var i = 0; i < routeArr.length; i++) {
//         if (routeArr[i].toLowerCase() == keyArr[i].toLowerCase() ||
//             keyArr[i].toLowerCase().startsWith(':')) {
//           if (keyArr[i].toLowerCase().startsWith(':')) {
//             compareMap['params'][keyArr[i].replaceFirst(':', '')] = routeArr[i];
//           }
//         } else {
//           return false;
//         }
//       }
//       return true;
//     }, orElse: () {
//       return '';
//     });
//     compareMap['route'] = matched;
//     return compareMap;
//   }

//   // void _handleRequests(
//   //     ExpressRequest req, ExpressResponse res, String reqType) async {
//   //   var reqTypeMap = getAllRoutes[reqType];
//   //   print(reqTypeMap.callback);

//   //   // req.sessions!.clear();

//   //   var path = req.path.endsWith('/')
//   //       ? req.path.replaceRange(req.path.length - 1, req.path.length, '')
//   //       : req.path;

//   //   Map mapRes = getRouteParams(path, reqTypeMap.callback)!;
//   //   Map params = mapRes.containsKey('params') ? mapRes['params'] : null;
//   //   req.params = params.cast<String, String>();
//   //   String? matched = mapRes['route'];
//   //   // print(matched);
//   //   List<Function(ExpressRequest, ExpressResponse)>? selectedCallbacks;

//   //   if (reqTypeMap.callback!.containsKey(path)) {
//   //     selectedCallbacks = reqTypeMap.callback![path];
//   //     Message().logInfo('Route: ${req.url}');
//   //   } else if (reqTypeMap.callback!.containsKey(path + '/')) {
//   //     selectedCallbacks = reqTypeMap.callback![path + '/'];
//   //     Message().logInfo('Route: ${req.url}');
//   //   } else if (matched != null) {
//   //     selectedCallbacks = reqTypeMap.callback![matched];
//   //     Message().logInfo('Route: ${req.url}');
//   //   } else {
//   //     selectedCallbacks = null;
//   //   }

//   //   // selectedCallbacks = reqTypeMap.containsKey(path)
//   //   //     ? reqTypeMap[path]
//   //   //     : matched != null ? reqTypeMap[matched] : null;

//   //   if (selectedCallbacks != null && selectedCallbacks.isNotEmpty) {
//   //     for (var func in selectedCallbacks) {
//   //       var result = await func(req, res);
//   //       // print(result.runtimeType);
//   //       if (result is ExpressResponse) {
//   //         await _consumeOpenFileStreams(req);
//   //         if (result.response.statusCode.toString().startsWith('2')) {
//   //           Message()
//   //               .logInfo('Status: ${result.response.statusCode.toString()}');
//   //         } else {
//   //           Message()
//   //               .logError('Status: ${result.response.statusCode.toString()}');
//   //         }
//   //         res.onClose();
//   //         break;
//   //       }
//   //     }
//   //   } else {
//   //     await _consumeOpenFileStreams(req);
//   //     for (var directory in expressDirs) {
//   //       var filePath = '${directory.dir!.path}${req.path}';
//   //       // print(filePath);
//   //       if (await File(filePath).exists()) {
//   //         (await res.statusCode(HttpStatus.ok).sendFile(filePath)).onClose();
//   //         return;
//   //       }
//   //     }

//   //     Message().logError(
//   //         'Cannot make request to this Route: ${req.url}. Check that this route exists.');

//   //     res
//   //         .statusCode(HttpStatus.notFound)
//   //         .toJson({'error': 'method not found'}).onClose();
//   //     // print(res.response.connectionInfo);
//   //   }
//   // }

//   void _handleRequests(
//       ExpressRequest req, ExpressResponse res, String reqType) async {
//     // print(req.path);
//     var reqTypeMap = getAllRoutes[reqType];
//     // print(reqTypeMap);
//     // req.sessions!.clear();

//     var path = req.path.endsWith('/')
//         ? req.path.replaceRange(req.path.length - 1, req.path.length, '')
//         : req.path;

//     Map mapRes = getRouteParams(path, reqTypeMap)!;
//     Map params = mapRes.containsKey('params') ? mapRes['params'] : null;
//     req.params = params.cast<String, String>();
//     String? matched = mapRes['route'];
//     // print(matched);
//     List<Function(ExpressRequest, ExpressResponse)>? selectedCallbacks;

//     if (reqTypeMap.containsKey(path)) {
//       selectedCallbacks = reqTypeMap[path];
//       Message().logInfo('Route: ${req.url}');
//     } else if (reqTypeMap.containsKey(path + '/')) {
//       selectedCallbacks = reqTypeMap[path + '/'];
//       Message().logInfo('Route: ${req.url}');
//     } else if (matched != null) {
//       selectedCallbacks = reqTypeMap[matched];
//       Message().logInfo('Route: ${req.url}');
//     } else {
//       selectedCallbacks = null;
//     }

//     // selectedCallbacks = reqTypeMap.containsKey(path)
//     //     ? reqTypeMap[path]
//     //     : matched != null ? reqTypeMap[matched] : null;

//     if (selectedCallbacks != null && selectedCallbacks.isNotEmpty) {
//       for (var func in selectedCallbacks) {
//         var result = await func(req, res);
//         // print(result.runtimeType);
//         if (result is ExpressResponse) {
//           await _consumeOpenFileStreams(req);
//           if (result.response.statusCode.toString().startsWith('2')) {
//             Message()
//                 .logInfo('Status: ${result.response.statusCode.toString()}');
//           } else {
//             Message()
//                 .logError('Status: ${result.response.statusCode.toString()}');
//           }

//           res.onClose();
//           break;
//         }
//       }
//     } else {
//       await _consumeOpenFileStreams(req);
//       for (var directory in expressDirs) {
//         var filePath = '${directory.dir!.path}${req.path}';
//         // print(filePath);
//         if (await File(filePath).exists()) {
//           (await res.statusCode(HttpStatus.ok).sendFile(filePath)).onClose();
//           return;
//         }
//       }

//       Message().logError(
//           'Cannot make request to this Route: ${req.url}. Check that this route exists.');

//       res
//           .statusCode(HttpStatus.notFound)
//           .toJson({'error': 'method not found'}).onClose();
//       // print(res.response.connectionInfo);
//     }
//   }

//   Future<void> _consumeOpenFileStreams(ExpressRequest req) async {
//     if (req.files.isNotEmpty) {
//       for (var i = 0; i < req.files.keys.length; i++) {
//         // var file = File(req.files[req.files.keys.toList()[i]].filename);
//         ExpressFile fileC;
//         fileC = req.files[req.files.keys.toList()[i]]!;
//         if (!fileC.streamController!.isClosed) {
//           await for (var data in fileC.streamController!.stream) {
//             //do nothing, consume file stream incase it wasn't consumed before to avoid throwing errors
//           }
//         }
//       }
//     }
//     return;
//   }

//   ///create a `get` request, route: uri, callbacks: list of callback functions to run
//   // dynamic get(String route,
//   //     List<Function(ExpressRequest req, ExpressResponse res)> callbacks) {
//   //   router.gets[route] = callbacks;
//   //   print(router.gets);
//   // }

//   dynamic get(ExpressMethod routeData) {
//     router.gets[routeData.route!] = routeData.callbacks!;
//   }

//   // /create a `post` request, route: uri, callbacks: list of callback functions to run.
//   dynamic post(ExpressMethod routeData) {
//     router.posts[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `patch` request, route: uri, callbacks: list of callback functions to run.
//   dynamic patch(ExpressMethod routeData) {
//     router.patchs[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `put` request, route: uri, callbacks: list of callback functions to run.
//   dynamic put(ExpressMethod routeData) {
//     router.puts[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `delete` request, route: uri, callbacks: list of callback functions to run.
//   dynamic delete(ExpressMethod routeData) {
//     router.deletes[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `copy` request, route: uri, callbacks: list of callback functions to run.
//   dynamic copy(ExpressMethod routeData) {
//     router.copys[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `head` request, route: uri, callbacks: list of callback functions to run.
//   dynamic head(ExpressMethod routeData) {
//     router.heads[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `options` request, route: uri, callbacks: list of callback functions to run.
//   dynamic options(ExpressMethod routeData) {
//     router.optionss[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `link` request, route: uri, callbacks: list of callback functions to run.
//   dynamic link(ExpressMethod routeData) {
//     router.links[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `unlink` request, route: uri, callbacks: list of callback functions to run.
//   dynamic unlink(ExpressMethod routeData) {
//     router.unlinks[routeData.route!] = routeData.callbacks!;
//   }
//   ///create a `purge` request, route: uri, callbacks: list of callback functions to run.
//   dynamic purge(ExpressMethod routeData) {
//     router.purges[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `lock` request, route: uri, callbacks: list of callback functions to run.
//   dynamic lock(ExpressMethod routeData) {
//     router.locks[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `unlock` request, route: uri, callbacks: list of callback functions to run.
//   dynamic unlock(ExpressMethod routeData) {
//     router.unlocks[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `propfind` request, route: uri, callbacks: list of callback functions to run.
//   dynamic propfind(ExpressMethod routeData) {
//     router.propfinds[routeData.route!] = routeData.callbacks!;
//   }

//   ///create a `view` request, route: uri, callbacks: list of callback functions to run.
//   dynamic view(ExpressMethod routeData) {
//     router.views[routeData.route!] = routeData.callbacks!;
//   }

//   ///Gets query Parameters
//   dynamic getQuery(String route) {
//     var uri = Uri.tryParse(route);

//     uri!.queryParameters;
//   }

//   /// Let Sevr Know where to find your files
//   dynamic use(dynamic obj) {
//     // Message().logInfo('Setting up server..');
//     switch (obj.runtimeType) {
//       case ExpressDir:
//         expressDirs.add(obj);
//         break;

//       case Router:
//         router.join(obj);
//         break;

//       case Cors:
//         cors = obj;
//         router.optionss
//             .addAll(router.gets.map((key, value) {
//           return MapEntry(key, [
//             (ExpressRequest req, ExpressResponse res) {
//               return res.statusCode(200);
//             }
//           ]);
//         }));
//         router.optionss
//             .addAll(router.posts.map((key, value) {
//           return MapEntry(key, [
//             (ExpressRequest req, ExpressResponse res) {
//               res.response.headers.removeAll('Content-Type');
//               res.response.headers.removeAll('x-content-type-options');
//               return res.statusCode(200);
//             }
//           ]);
//         }));
//         // router.optionss.addAll(router.gets.map((key, value){
//         //   return MapEntry(key, [(ExpressRequest req, ExpressResponse res){
//         //         return res.status(200);
//         //       }]);
//         // }));

//         break;
//       default:
//     }
//   }

//   @override
//   bool autoCompress;

//   @override
//   Duration? idleTimeout;

//   @override
//   String? serverHeader;

//   @override
//   // TODO: implement address
//   InternetAddress get address => throw UnimplementedError();

//   @override
//   Future close({bool force = false}) {
//       // TODO: implement close
//       throw UnimplementedError();
//     }
  
//     @override
//     HttpConnectionsInfo connectionsInfo() {
//       // TODO: implement connectionsInfo
//       throw UnimplementedError();
//     }
  
//     @override
//     // TODO: implement defaultResponseHeaders
//     HttpHeaders get defaultResponseHeaders => throw UnimplementedError();
  
//     @override
//     set sessionTimeout(int timeout) {
//     // TODO: implement sessionTimeout
//   }
// }
