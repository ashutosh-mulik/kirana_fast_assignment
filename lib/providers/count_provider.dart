import 'package:flutter/widgets.dart';

class CountProvider extends ChangeNotifier {
  double _count = 3.0;

  get count => _count;

  void changeCount(value) {
    _count = value;
    notifyListeners();
  }
}
