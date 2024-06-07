import 'dart:developer';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> readProfile() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.readProfile);
    log(response.responseData.toString());
    if (response.isSuccess && response.responseData != null) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
