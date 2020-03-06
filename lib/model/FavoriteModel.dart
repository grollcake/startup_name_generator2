import 'package:flutter/foundation.dart';

class FavoriteModel with ChangeNotifier {
  List<String> _saved = <String>[];

  List<String> get saved => _saved;

  void toggleFavorite(String name) {
    if (_saved.contains(name)) {
      _saved.remove(name);
    } else {
      _saved.add(name);
    }
    notifyListeners();
  }

  bool isFavorite(String name) {
    return _saved.contains(name);
  }

  int get count => _saved.length;
}