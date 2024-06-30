import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/wish_item_model.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<WishItemModel> _wishList = [];

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  List<WishItemModel> get wishList => _wishList;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.getWishList);
    if (response.isSuccess) {
      _wishList = WishListModel.fromJson(response.responseData).wishList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> removeWishList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.removeWishList(productId));
    if (response.isSuccess) {
      _removeWishList(productId);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  void _removeWishList(int productId){
    _wishList.removeWhere((p) => p.id == productId);
  }

}
