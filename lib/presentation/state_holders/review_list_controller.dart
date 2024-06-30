import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/review_item_model.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<ReviewItemModel> _reviewList = [];

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  List<ReviewItemModel> get reviewList => _reviewList;

  Future<bool> getReviewList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.reviewListByProduct(productId));
    if (response.isSuccess) {
      _reviewList = ReviewListModel.fromJson(response.responseData).reviewList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
