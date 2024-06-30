import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  late int _counterValue;

  @override
  void initState() {
    super.initState();
    _counterValue = widget.cartItem.qty!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductDetails(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductName(),
                  _buildProductVariants(),
                ],
              ),
            ),
            IconButton(
              onPressed: _deleteProductItem,
              icon: const Icon(Icons.delete_outline_sharp),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProductPrice(),
            _buildCounterButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildProductPrice() {
    return Text(
      '\$${widget.cartItem.product?.price ?? 0}',
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.primaryColor,
      ),
    );
  }

  Wrap _buildProductVariants() {
    return Wrap(
      spacing: 16,
      children: [
        Text(
          'Color: ${widget.cartItem.color ?? ''}',
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        Text(
          'Size: ${widget.cartItem.size ?? ''}',
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildCounterButton() {
    return ItemCount(
      //make a custom button instead of package
      initialValue: _counterValue,
      minValue: 1,
      maxValue: 20,
      decimalPlaces: 0,
      color: AppColors.primaryColor,
      onChanged: (value) {
        _counterValue = value as int;
        //setState(() {}); use it if it doesn't work
        Get.find<CartListController>()
            .changeProductQuantity(widget.cartItem.id!, _counterValue);
      },
    );
  }

  Widget _buildProductName() {
    return Text(
      widget.cartItem.product?.title ?? '',
      maxLines: 1,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        widget.cartItem.product?.image ?? '',
        width: 100,
      ),
    );
  }

  void _deleteProductItem() async {
    bool isDeleted = await Get.find<CartListController>()
        .deleteCartItem(widget.cartItem.id!);

    if(mounted){
      if (!isDeleted) {
        showSnackMessage(context, CartListController().errorMessage);
      }
    }
  }
}
