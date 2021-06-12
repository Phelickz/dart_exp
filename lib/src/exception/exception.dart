class ExpressException {
  final List? _exception;

  ExpressException(this._exception);

  static ExpressException from(List e){
    return ExpressException(e);
  }

  void throwException() {
    print(_exception![1]);
    throw _exception![0];
  }

}