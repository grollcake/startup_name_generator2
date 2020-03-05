import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';

class NamesModel with ChangeNotifier {
  List<String> _names = <String>[];

  void _generateOne() {
    _names.add(WordPair.random().asPascalCase.toString());
    notifyListeners();
  }

  String getName(int index) {
    if (index >= _names.length) {
      _generateOne();
    }
    return _names[index];
  }

  int getCount() {
    return _names.length;
  }
}