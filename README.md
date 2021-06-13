# dart_express

A light weight library for building REST APIS easily with Dart.

The library is still a work in progress and open to contribution

## Installing

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  dart_express: any
```

## Usage
```dart

import 'dart:io';
import 'dart:math';

import 'package:dart_express/dart_express.dart';
import 'package:dart_express/src/model/get.dart';
import 'package:dart_express/src/wrapper/cors.dart';
import 'package:path/path.dart' as p;

dynamic main() {
  // DoSomeWork('Felix').newExpressLoggy('name');

  var express = Express();

  //let express know to serve from the /web directory
  express.use(Express.static('example/web'));

  //Allowe cross Origin requests
  express.use(Cors(['*']));

  //Use path to get directory of the files to serve on that route

  express.get(ExpressMethod(route: '/home', callbacks: [
    (ExpressRequest req, ExpressResponse res) {
      int numb = Random().nextInt(7);
      if (numb % 2 == 0) {

      } else {
        return res
            .statusCode(400)
            .toJson({"message": "Only even numbers allowed"});
      }
    },
    (
      ExpressRequest req,
      ExpressResponse res,
    ) {

      return res.statusCode(200).sendFile(p.absolute('web/index.html'));
    }
  ]));

  express.get(ExpressMethod(route: '/', callbacks: [
    (ExpressRequest req, ExpressResponse res) {
      int numb = Random().nextInt(7);
      // print(numb);
      if (numb % 2 == 0) {
      } else {
        return res
            .statusCode(400)
            .toJson({"message": "Only even numbers allowed"});
      }
    },
    (ExpressRequest req, ExpressResponse res) {
      // req.sessions!.addAll({'state': "secret"});
      return res.statusCode(200).send('<h1>Hello World</h1>');
    },
  ]));
  
  //post request

  express.post(ExpressMethod(route: '/post', callbacks: [
    (ExpressRequest req, ExpressResponse res) async {
      return res.statusCode(200).toJson(req.body);
    }
  ]));

  //plain text

  express.get(ExpressMethod(route: '/text', callbacks: [
    (ExpressRequest req, ExpressResponse res) {
      return res.statusCode(200).send('data');
    }
  ]));

  // request parameters

  express.get(ExpressMethod(route: '/param/:username', callbacks: [
    (ExpressRequest req, ExpressResponse res) {
      return res.statusCode(200).toJson({'params': req.params});
    }
  ]));

  // query parameters
  express.get(ExpressMethod(route: '/query', callbacks: [
    (ExpressRequest req, ExpressResponse res) {
      return res.statusCode(200).toJson(req.query);
    }
  ]));

  //Upload Files

  express.post(ExpressMethod(route: 'upload', callbacks: [
    (req, res) async {
      for (var i = 0; i < req.files.keys.length; i++) {
        //Handle your file stream as you see fit, write to file, pipe to a cdn etc --->
        var file = File(req.files[req.files.keys.toList()[i]]!.filename!);
        await for (var data in req
            .files[req.files.keys.toList()[i]]!.streamController!.stream) {
          if (data is String) {
            await file.writeAsString(data, mode: FileMode.append);
          } else {
            await file.writeAsBytes(data, mode: FileMode.append);
          }
        }
      }

      return res.statusCode(200).toJson(req.body);
    }
  ]));

  //Bind server to port 4000
  express.stream(4000, callback: () {});
}
```

#### Make Requests
- Use the ExpressMethod to make a request.
- It takes in a route parameter and a list of callback functions.
- The function can be just one, or you can have a middleware and your callback functinon.
- The callback function takes `ExpressRequest` and `ExpressResponse` as parameters


Other available request types:

- `PUT`
- `PATCH`
- `DELETE`
- `COPY`
- `HEAD`
- `OPTIONS`
- `LINK`
- `UNLINK`
- `PURGE`
- `LOCK`
- `UNLOCK`
- `PROFIND`
- `VIEW`


#### Working with html files

```dart
//let express know to serve from the /web directory
  express.use(Express.static('example/web'));

  express.get(ExpressMethod(route: '/home', callbacks: [

    (
      ExpressRequest req,
      ExpressResponse res,
    ) {

      return res.statusCode(200).sendFile(p.absolute('web/index.html'));
    }
  ]));

```
