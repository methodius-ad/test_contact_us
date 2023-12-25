import 'package:flutter/cupertino.dart';

abstract class BaseViewModel with ChangeNotifier {
  /// avoid some boilerplate for loading state and other common things we can have
  bool isLoading = false;

  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }
}