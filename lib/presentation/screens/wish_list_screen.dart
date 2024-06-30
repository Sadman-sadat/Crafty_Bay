import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    // Delaying the call to getCartList to prevent calling setState during build
    Future.microtask(() => Get.find<WishListController>().getWishList());
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
          title: const Text('Wishlist'),
          leading: IconButton(
              onPressed: () {
                Get.find<MainBottomNavBarController>().backToHome();
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        ),
        body: GetBuilder<WishListController>(builder: (wishListController) {
          if (wishListController.inProgress) {
            return const CenteredCircularProgressIndicator();
          }

          return RefreshIndicator(
            onRefresh: () async {
              wishListController.getWishList();
            },
            child: GridView.builder(
              //give padding here if it breaks on upper widget
              itemCount: wishListController.wishList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                final wishItem = wishListController.wishList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: FittedBox(
                    child: ProductCard(
                      showAddToWishList: false,
                      product: wishItem.product!,
                      onWishlistTap: () async {
                        await wishListController.removeWishList(wishItem.product!.id!);
                        await wishListController.getWishList();
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
