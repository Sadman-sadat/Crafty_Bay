import 'package:crafty_bay/data/models/products_model.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_slider_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:crafty_bay/presentation/widgets/app_bar_icon_button.dart';
import 'package:crafty_bay/presentation/widgets/app_section_header.dart';
import 'package:crafty_bay/presentation/widgets/category_item.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/widgets/home_carousel_slider.dart';
import 'package:crafty_bay/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/data/models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 16),
              GetBuilder<HomeSliderController>(builder: (homeSliderController) {
                if (homeSliderController.inProgress) {
                  return const SizedBox(
                    height: 220,
                    child: CenteredCircularProgressIndicator(),
                  );
                }
                return HomeCarouselSlider(
                    sliderList: homeSliderController.sliderList);
              }),
              const SizedBox(height: 16),
              SectionHeader(
                title: 'All Category',
                onTapSeeAll: () {
                  Get.find<MainBottomNavBarController>().selectCategory();
                },
              ),
              const SizedBox(height: 10),
              GetBuilder<CategoryListController>(
                  builder: (categoryListController) {
                if (categoryListController.inProgress) {
                  return const SizedBox(
                    height: 120,
                    child: CenteredCircularProgressIndicator(),
                  );
                }
                return _buildCategoryListView(
                    categoryListController.categoryList);
              }),
              const SizedBox(height: 8),
              SectionHeader(
                title: 'Popular',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 10),
              GetBuilder<PopularProductListController>(
                  builder: (popularProductListController) {
                if (popularProductListController.inProgress) {
                  return const SizedBox(
                    height: 240,
                    child: CenteredCircularProgressIndicator(),
                  );
                }
                return _buildProductListView(
                  popularProductListController.productList,
                );
              }),
              const SizedBox(height: 8),
              SectionHeader(
                title: 'Special',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 10),
              GetBuilder<SpecialProductListController>(
                  builder: (specialProductListController) {
                if (specialProductListController.inProgress) {
                  return const SizedBox(
                    height: 240,
                    child: CenteredCircularProgressIndicator(),
                  );
                }
                return _buildProductListView(
                  specialProductListController.productList,
                );
              }),
              const SizedBox(height: 8),
              SectionHeader(
                title: 'New',
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 10),
              GetBuilder<NewProductListController>(
                  builder: (newProductListController) {
                if (newProductListController.inProgress) {
                  return const SizedBox(
                    height: 240,
                    child: CenteredCircularProgressIndicator(),
                  );
                }
                return _buildProductListView(
                  newProductListController.productList,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetPath.appNavLogoSvg),
      actions: [
        AppBarIconButton(
          icon: Icons.person,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          icon: Icons.call,
          onTap: () {},
        ),
        const SizedBox(width: 8),
        AppBarIconButton(
          icon: Icons.notifications_active_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildCategoryListView(List<Category> categoryList) {
    return SingleChildScrollView(
      // child: SizedBox(
      //   height: 120,
      //   child: ListView.separated(
      //     itemCount: categoryList.length,
      //     scrollDirection: Axis.horizontal,
      //     itemBuilder: (context, index) {
      //       return CategoryItem(
      //         category: categoryList[index],
      //       );
      //     },
      //     separatorBuilder: (BuildContext context, index) {
      //       return const SizedBox(width: 16);
      //     },
      //   ),
      // ),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryList.map((e) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: CategoryItem(category: e),
        )).toList(),
      ),
    );
  }

  Widget _buildProductListView(List<Product> productList) {
    return SizedBox(
      // height: 240,
      // child: ListView.separated(
      //   itemCount: productList.length,
      //   scrollDirection: Axis.horizontal,
      //   itemBuilder: (context, index) {
      //     return ProductCard(
      //       product: productList[index],
      //     );
      //   },
      //   separatorBuilder: (BuildContext context, index) {
      //     return const SizedBox(width: 8);
      //   },
      // ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: productList.map((e) => ProductCard(product: e)).toList(),
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return TextFormField(
      controller: _searchTEController,
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: const Icon(Icons.search_outlined),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchTEController.dispose();
    super.dispose();
  }
}
