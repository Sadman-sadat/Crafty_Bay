
import 'package:crafty_bay/data/models/products_model.dart';
import 'package:crafty_bay/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/add_to_wish_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,  this.showAddToWishList = true, required this.product, this.onWishlistTap,
  });

  final bool showAddToWishList;
  final Product product;
  final VoidCallback? onWishlistTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => ProductDetailsScreen(productId: product.id!,));
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 160,
          child: Column(
            children: [
              Container(
                //width: 130,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(product.image ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Wrap(
                      spacing: 5,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('\$${product.price}', style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),),
                         Wrap(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18,),
                            Text('\$${product.star}'),
                          ],
                        ),
                        const SizedBox(
                          width: 05,
                        ),
                        GetBuilder<WishListController>(
                            builder: (wishListController) {
                              bool isInWishlist = wishListController.wishList.any((item) => item.product?.id == product.id);
                              if(wishListController.inProgress){
                                return Transform.scale(
                                  scale: 0.4,
                                  child: const CircularProgressIndicator(),);
                              }
                              return WishButton(showAddToWishList: showAddToWishList, onTap: onWishlistTap ?? () {
                                if (isInWishlist) {
                                  wishListController.removeWishList(product.id!);
                                } else {
                                  Get.find<AddToWishListController>().addToWishList(product.id!);
                                }

                                //need to fix. all of the wish button is showing circular indicator on tap
                                //addToWishListController.addToWishList(product.id!);
                              },);
                            }
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    }

}