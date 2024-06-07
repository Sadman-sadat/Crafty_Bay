import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/slider_data_model.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:crafty_bay/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
    required this.sliderList,
  });

  final List<Category> sliderList;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedPageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        const SizedBox(height: 12),
        _buildSliderDotIndicator()
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          height: 180,
          viewportFraction: 1,
          onPageChanged: (index, _) {
            _selectedPageIndex.value = index;
          }),
      items: widget.sliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: NetworkImageWidget(
                      url: slider.image ?? '',
                      height: double.maxFinite,
                      widget: double.maxFinite,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  _buildProductDescription(slider),
                  _buildCarouselButton(),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildProductDescription(Category slider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0, left: 16.0, right: 150.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              slider.title ?? '',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              slider.shortDes ?? '',
              maxLines: 4,
              style: const TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCarouselButton() {
    return Positioned(
      left: 20,
      bottom: 8,
      child: SizedBox(
        width: 180,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 6),
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {},
          child: const Text('Buy now'),
        ),
      ),
    );
  }

  Widget _buildSliderDotIndicator() {
    return ValueListenableBuilder(
      valueListenable: _selectedPageIndex,
      builder: (context, currentPage, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.sliderList.length; i++)
              Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i == currentPage ? AppColors.primaryColor : null,
                  border: Border.all(
                    color:
                        i == currentPage ? AppColors.primaryColor : Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
          ],
        );
      },
    );
  }
}
