import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class WishButton extends StatelessWidget {
  const WishButton({
    super.key,
    this.showAddToWishList = true,
    this.isSelected = false,
    required this.onTap,
  });

  final bool showAddToWishList;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Icon(
              showAddToWishList
                  ? (isSelected ? Icons.favorite : Icons.favorite_outline)
                  : Icons.delete_outline,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
