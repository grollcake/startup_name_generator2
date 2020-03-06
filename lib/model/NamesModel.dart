import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';

class NamesModel with ChangeNotifier {

  List<String> _names = <String>[];
  StreamController<int> _streamController;

  NamesModel() {
   _streamController = StreamController();
  }

  void _generateOne() {
    String name = WordPair.random().asPascalCase.toString();
    _names.add(name);
    _streamController.add(_names.length);
    print('Generated $name');
  }

  String getName(int index) {
    if (index >= _names.length) {
      _generateOne();
    }
    return _names[index];
  }

  int get count => _names.length;

  Stream<int> get stream => _streamController.stream;
}