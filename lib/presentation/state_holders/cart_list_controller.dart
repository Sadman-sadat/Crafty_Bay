import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/network_caller/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';


class CartListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  List<CartItemModel> _cartList = [];

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  List<CartItemModel> get cartList => _cartList;

  Future<bool> getCartList() async {
    print("Fetching cart list");
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getCartList);
    if (response.isSuccess) {
      _cartList = CartListModel.fromJson(response.responseData).cartList ?? [];
      print("Fetched cart list: $_cartList");
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
      print("Error fetching cart list: $_errorMessage");
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

  double get totalPrice{
    double total = 0;
    for(CartItemModel cartItem in _cartList){
      total += (cartItem.qty!) * (double.tryParse(cartItem.product?.price ?? '0') ?? 0);
    }
    return total;
  }

  void changeProductQuantity(int cartId, int quantity){
    _cartList.firstWhere((c) => c.id == cartId).qty = quantity;
    update();
  }

  void _deleteCartItem(int cartId){
    print("Attempting to delete item with cartId: $cartId");
    print("Cart list before deletion: $_cartList");
    _cartList.removeWhere((c) => c.id == cartId);
    print("Cart list after deletion: $_cartList");
    update();
  }


  Future<bool> deleteCartItem(int cartId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    print("Sending delete request for cartId: $cartId");
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.deleteCartList(cartId));
    if (response.isSuccess) {
      _deleteCartItem(cartId);
      print("Remove successfully: $cartId");
      print("Cart list after deletion: $_cartList");
      isSuccess = true;
    } else {
      print("Error deleting item: ${response.errorMessage}");
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }

}