import 'package:universal_io/io.dart';

class ExpressDir {
  Directory? dir;
  ExpressDir(String dirString) {
    dir = Directory(dirString);
  }
}
