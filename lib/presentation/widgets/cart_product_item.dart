import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({super.key});

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  int _counterValue = 1;

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
              onPressed: () {},
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
    return const Text(
      '\$100',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.primaryColor,
      ),
    );
  }

  Wrap _buildProductVariants() {
    return const Wrap(
      spacing: 16,
      children: [
        Text(
          'Color: Red',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Text(
          'Size: XL',
          style: TextStyle(
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
        setState(() {});
      },
    );
  }

  Widget _buildProductName() {
    return const Text(
      'Nike Shoe 3265265KH2',
      maxLines: 1,
      style: TextStyle(
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
      child: SvgPicture.asset(
        AssetPath.productDummyImgSvg,
        width: 100,
      ),
    );
  }
}
