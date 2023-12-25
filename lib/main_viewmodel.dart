import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_contact_us/base_viewmodel.dart';

import 'data/data_result.dart';
import 'domain/use_case/send_data_use_case.dart';

class MainViewModel extends BaseViewModel {
  final SendDataUseCase sendDataUseCase;

  MainViewModel({
    required this.sendDataUseCase,
  }) {
    nameInputController.addListener(_onNameChanged);
    emailInputController.addListener(_onEmailChanged);
    messageInputController.addListener(_onMessageChanged);
  }

  TextEditingController nameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController messageInputController = TextEditingController();

  bool _isValidEmail = true;

  bool get isValidEmail => _isValidEmail;

  bool get isSendEnabled => _isSendEnabled;
  bool _isSendEnabled = false;

  String get name => _name;

  String get email => _email;

  String get message => _message;

  Color get btnTextColor => _btnTextColor;

  String _name = "";
  String _email = "";
  String _message = "";
  Color _btnTextColor = Colors.grey;

  bool isSendDataEnabled() {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        message.isNotEmpty &&
        isValidEmail;
  }

  void _onNameChanged() {
    _name = nameInputController.text;
    _isSendEnabled = isSendDataEnabled();
    _btnTextColor = isSendDataEnabled() ? Colors.white : Colors.grey;
    notifyListeners();
  }

  void _onEmailChanged() {
    _email = emailInputController.text;
    _isSendEnabled = isSendDataEnabled();
    _btnTextColor = isSendDataEnabled() ? Colors.blue : Colors.grey;
    validateEmail(_email);
    notifyListeners();
  }

  void _onMessageChanged() {
    _message = messageInputController.text;
    _isSendEnabled = isSendDataEnabled();
    _btnTextColor = isSendDataEnabled() ? Colors.blue : Colors.grey;
    notifyListeners();
  }

  void validateEmail(String value) {
    const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    final regExp = RegExp(emailPattern);
    _isValidEmail = regExp.hasMatch(value);
    notifyListeners();
  }

  Future<void> sendData({required Function onSuccess, required Function(String message) onError}) async {
    showLoading();
    try {
      DataResult<Map<String, dynamic>> dataList =
          await sendDataUseCase.processData(name, email, message);

      if(dataList.isSuccess()) {
        onSuccess();
      } else {
        onError(dataList.errorMessage ?? "");
      }
    } on DioError catch(err) {
      onError(err.message);
    } catch (error) {
      onError("some error occurred" ?? "");
      /// Handle errors
    }
    hideLoading();
  }
}
