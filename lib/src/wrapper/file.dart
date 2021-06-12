import 'dart:async';

class ExpressFile {
  StreamController? streamController;
  String? filename;
  String? name;

  ExpressFile(this.filename, this.name, this.streamController);
}
