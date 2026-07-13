import 'package:flutter/foundation.dart';

class DestinationProvider extends ChangeNotifier {
  String _query='';
  String get query=>_query;
  void search(String value){
    _query=value;
    notifyListeners();
  }
}
