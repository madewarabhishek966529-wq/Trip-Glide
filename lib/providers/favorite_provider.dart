import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier{
  final Set<String> _favorites={};
  Set<String> get favorites=>_favorites;
  bool isFavorite(String id)=>_favorites.contains(id);
  void toggle(String id){
    if(!_favorites.add(id)){_favorites.remove(id);}
    notifyListeners();
  }
}
