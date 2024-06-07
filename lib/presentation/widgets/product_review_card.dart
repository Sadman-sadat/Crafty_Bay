import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductReviewCard extends StatelessWidget {
  const ProductReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        height: 140,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(AssetPath.profileImgSvg),
                    ),
                    const SizedBox(width: 10),
                    Text('Rabbil Hasan', style:Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black54),),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const Text('''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean eget enim quis augue elementum viverra non ut odio, sit amet pharetra metus erat a velit. ''',
                style: TextStyle( fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
