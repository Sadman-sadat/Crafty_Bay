import 'package:crafty_bay/data/models/cart_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/profile_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> createProfile(String name, String address, String city,
      String state, String postcode, String country, String mobile,
      String fax) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      'cusName': name,
      'cusAdd': address,
      'cusCity': city,
      'cusState': state,
      'cusPostcode': postcode,
      'cusCountry': country,
      'cusPhone': mobile,
      'cusFax': fax,
      'shipName': name,
      'shipAdd': address,
      'shipCity': city,
      'shipState': state,
      'shipPostcode': postcode,
      'shipCountry': country,
      'shipPhone': mobile,
    };

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.createProfile, body: inputParams);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
