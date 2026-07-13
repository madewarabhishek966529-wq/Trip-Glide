import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier{
  int index=0;
  void change(int value){
    index=value;
    notifyListeners();
  }
}
