import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/widgets/bottomActonCard.dart';
import 'package:crafty_bay/presentation/widgets/cart_product_item.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {

  @override
  void initState() {
    super.initState();
    // Delaying the call to getCartList to prevent calling setState during build
    Future.microtask(() => Get.find<CartListController>().getCartList());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        Get.find<MainBottomNavBarController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carts'),
          leading: IconButton(
              onPressed: () {
                Get.find<MainBottomNavBarController>().backToHome();
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        ),
        body: GetBuilder<CartListController>(
          builder: (cartListController) {
            if(cartListController.inProgress){
              return const CenteredCircularProgressIndicator();
            }

            return RefreshIndicator(
              onRefresh: () async {
                await cartListController.getCartList();
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartListController.cartList.length,
                      itemBuilder: (context, index) {
                        return CartProductItem(cartItem: cartListController.cartList[index],);
                      },
                    ),
                  ),
                  BottomActionCard(
                    buttonSize: 120,
                    mainText: 'Total Price',
                    subText: '\$${cartListController.totalPrice.toStringAsFixed(2)}',
                    buttonChild: const Text('Check out'),
                    onButtonPressed: () {},
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
