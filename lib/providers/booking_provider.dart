import 'package:flutter/foundation.dart';

class BookingProvider extends ChangeNotifier{
  int guests=1;
  void increment(){guests++;notifyListeners();}
  void decrement(){if(guests>1){guests--;notifyListeners();}}
}
