import 'dart:io';

class ExpressDir {
  Directory? dir;
  ExpressDir(String dirString) {
    dir = Directory(dirString);
  }
}