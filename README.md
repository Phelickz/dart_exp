# express_dt

![Twitter Follow](https://img.shields.io/twitter/follow/FeolixaHope?style=social)

A light weight library for building REST APIS easily with Dart.

<code><img height="24" src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/dart/dart.png"></code>

The library is still a work in progress and open to contribution

## Installing

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  express_dt: any
```

## Usage
```dart

import 'package:universal_io/io.dart';
import 'dart:math';

import 'package:express_dt/express_dt.dart';
import 'package:express_dt/src/model/get.dart';
import 'package:express_dt/src/wrapper/cors.dart';
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

  //route to create a jwt token
  express.get(ExpressMethod(route: '/tokenRoute', callbacks: [
    (req, res) {
      String token = expressSign('Sjkbdjaksdjas', env['EXPRESS_SECRET_KEY']!);
      return res.statusCode(200).toJson({"token": token});
    }
  ]));


  //route with a middleware to verify jwt token
  express.get(ExpressMethod(route: '/verifyToken', callbacks: [
    (req, res) {
      String? token = extractTokenFromHeader(req.headers);
      if (token == null) {
        return res.statusCode(400).send('Authorization Failed');
      } else {
        var data = expressVerify(token, env['EXPRESS_SECRET_KEY']!);
        if (data == null) {
          return res.statusCode(400).send('Authorization Failed');
        }
      }
    },
    (req, res) {
      return res.statusCode(200).send('Authorized');
    }
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


#### Secure routes
```dart
//route to create a jwt token
  express.get(ExpressMethod(route: '/tokenRoute', callbacks: [
    (req, res) {

      //Use expressSign() to create a token with the id and your secret key
      String token = expressSign('Sjkbdjaksdjas', env['EXPRESS_SECRET_KEY']!);
      return res.statusCode(200).toJson({"token": token});
    }
  ]));


  //route with a middleware to verify jwt token
  express.get(ExpressMethod(route: '/verifyToken', callbacks: [
    (req, res) {
      //Extract token from header
      String? token = extractTokenFromHeader(req.headers);
      if (token == null) {
        return res.statusCode(400).send('Authorization Failed');
      } else {
        //Verify the token
        var data = expressVerify(token, env['EXPRESS_SECRET_KEY']!);
        if (data == null) {
          return res.statusCode(400).send('Authorization Failed');
        }
      }
    },
    //proceed to the request
    (req, res) {
      return res.statusCode(200).send('Authorized');
    }
  ]));
```

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

#### Managing Sessions

You can manage sessions in two ways.
You can either let express_dt manage sessions for you or you can do it manually for weach route.
If you let express_dt manage sessions for you, all routes are protected by the session, and the route fails when the session authorization fails. The session value is also encrypted using JWT and is stored in the user cookies.
This method is not flexible or customizable. Atleast not yet.
Here is an example.

```Dart
import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'dart:math';
import 'package:express_dt/express_dt.dart';
import 'package:path/path.dart' as p;
import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;

dynamic main() {
  load();
   var config =
      ExpressJwtConfig(env['EXPRESS_SECRET_KEY']!, issuer: 'express.com');

  var expressSession =
      JwtSession(config, io: SessionIoCookie(cookieName: 'express'));

  var express = Express();

    //let express know to serve from the /web directory
  express.use(Express.static('example/web'));

  //Allowe cross Origin requests
  express.use(Cors(['*']));

  //do this if you want all routes to be protected by session. Routes will fail with unauthorzed sessions.
  express.use(ExpressSessions(env['EXPRESS_SECRET_KEY']!, expressSession));

  //Manage sessions example
  //This route creates a session automatically because we have told express to use EXPRESS SESSION above
  express.post(ExpressMethod(route: '/sessions', callbacks: [
    (req, res) async {
      // print(res.cookies.toString());
      return res.statusCode(200).toJson({'session': res.cookies.toString()});
    }
  ]));

  //this route verifies session.
//Request fails if the session is invalid

  //Verify session
  express.get(
    ExpressMethod(
      route: '/verify_sessions',
      callbacks: [
        (req, res) async {
          Session session = await expressSession.parse(req);
          print(session['authorization']);
        }
      ],
    ),
  );
}
```

But if you are like me that wants flexibility and ofcourse, you might not want all your routes to be protected.. or you might want to handle your errors programmatically, then the manual way is the right way to go.

```Dart
import 'dart:async';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'dart:math';
import 'package:express_dt/express_dt.dart';
import 'package:path/path.dart' as p;
import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;

var express = Express();

    //let express know to serve from the /web directory
express.use(Express.static('example/web'));

  //Allowe cross Origin requests
express.use(Cors(['*']));

  //post request
//Handle session manually
  express.post(ExpressMethod(route: '/post', callbacks: [
    (ExpressRequest req, ExpressResponse res) async {
//Handle session manually
      final Session session = await req.session;
      session.clear();
      session['authorization'] = 'AuthorizationValue';
      //save the value in the response cookie
      res.cookiess(Cookie('authorization', 'AuthorizationValue'));
      return res.statusCode(200).toJson({"sas": res.cookies});
    }
  ]));

  //plain text
//manually verify session
  express.get(ExpressMethod(route: '/text', callbacks: [
    (ExpressRequest req, ExpressResponse res) async {
      //manually check session
      print(req.cookies.toString());
      Cookie? auth = req.cookies['authorization'];
      if (auth == null || auth.value != 'AuthorizationValue') {
        return res.statusCode(HttpStatus.unauthorized);
      }

      return res.statusCode(200).send('data');
    }
  ]));

```
In the upcoming releases, I'll work on the flexibility of the automatic sessions.
