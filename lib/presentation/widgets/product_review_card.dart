import 'package:crafty_bay/data/models/review_item_model.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductReviewCard extends StatefulWidget {
  const ProductReviewCard({
    super.key,
    required this.reviewItem,
  });

  final ReviewItemModel reviewItem;

  @override
  State<ProductReviewCard> createState() => _ProductReviewCardState();
}

class _ProductReviewCardState extends State<ProductReviewCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 1.5,
      //surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: isSmallScreen ? 24 : 30,
                  width: isSmallScreen ? 24 : 30,
                  child: SvgPicture.asset(AssetPath.profileImgSvg),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.reviewItem.profile?.cusName ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black54,
                    fontSize: isSmallScreen ? 16 : 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.reviewItem.description ?? '',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
