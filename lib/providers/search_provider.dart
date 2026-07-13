import 'package:flutter/foundation.dart';

class SearchProvider extends ChangeNotifier{
  String text='';
  void update(String value){
    text=value;
    notifyListeners();
  }
}
