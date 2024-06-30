import 'package:crafty_bay/presentation/screens/cart_list_screen.dart';
import 'package:crafty_bay/presentation/screens/category_list_screen.dart';
import 'package:crafty_bay/presentation/screens/home_screen.dart';
import 'package:crafty_bay/presentation/screens/wish_list_screen.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crafty_bay/presentation/state_holders/home_slider_controller.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final MainBottomNavBarController _mainBottomNavBarController = Get.find<MainBottomNavBarController>();
  final HomeSliderController _homeSliderController = Get.find<HomeSliderController>();
  final CategoryListController _categoryListController = Get.find<CategoryListController>();
  final PopularProductListController _popularProductListController = Get.find<PopularProductListController>();
  final NewProductListController _newProductListController = Get.find<NewProductListController>();
  final SpecialProductListController _specialProductListController = Get.find<SpecialProductListController>();

  @override
  void initState() {
    super.initState();
    // _homeSliderController.getSliders();
    // _categoryListController.getCategoryList();
    // _popularProductListController.getPopularProductList();
    // _newProductListController.getNewProductList();
    // _specialProductListController.getSpecialProductList();

    // Delaying the call to getCartList to prevent calling setState during build
    Future.microtask(() => _homeSliderController.getSliders());
    Future.microtask(() => _categoryListController.getCategoryList());
    Future.microtask(() => _popularProductListController.getPopularProductList());
    Future.microtask(() => _newProductListController.getNewProductList());
    Future.microtask(() =>_specialProductListController.getSpecialProductList());
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(),
    const CartListScreen(),
    const WishListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavBarController>(
        builder: (_){
          return _screens[_mainBottomNavBarController.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
        builder: (_) {
          return BottomNavigationBar(
            currentIndex: _mainBottomNavBarController.selectedIndex,
            onTap: (index){
              _mainBottomNavBarController.changeIndex(index);
            },
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Category'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded), label: 'Wishlist'),
            ],
          );
        }
      ),
    );
  }
}
