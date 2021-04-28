import 'package:flutter/foundation.dart';

class ItemQuantity with ChangeNotifier {
  int _numbersOfItems = 0;
  int get numberOfItems => _numbersOfItems;
  display(int no){
    _numbersOfItems = no;
    notifyListeners();
  }
}
