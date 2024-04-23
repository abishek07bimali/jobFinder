import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteStateProvider = StateProvider((ref) => false);

class FavoriteState extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
