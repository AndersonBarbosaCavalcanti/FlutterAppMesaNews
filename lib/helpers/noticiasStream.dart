
import 'dart:async';

import 'package:rxdart/rxdart.dart';

class NoticiasStream {

  final _controller = BehaviorSubject<dynamic>();
  
  Stream get output => _controller.stream;

  Sink get input => _controller.sink;

  addData(text) {
    if (!_controller.isClosed)
    input.add(text);
  }

  void dispose() {
    _controller.close();
  }
}