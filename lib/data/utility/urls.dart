class Urls{
  static const String _baseUrl = 'http://ecom-api.teamrabbil.com/api';

  static const String homeSlider = '$_baseUrl/ListProductSlider';
  static const String categoryList = '$_baseUrl/CategoryList';
  static const String addToCart = '$_baseUrl/CreateCartList';
  static const String createProfile = '$_baseUrl/CreateProfile';
  static const String readProfile = '$_baseUrl/ReadProfile';
  static const String getWishList = '$_baseUrl/ProductWishList';

  static String productListByCategory(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';
  static String productDetails(int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static String productListByRemark(String remark) => '$_baseUrl/ListProductByRemark/$remark';
  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';
  static String verifyOtp(String email, String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static String createWishList(int productId) => '$_baseUrl/CreateWishList/$productId';
}