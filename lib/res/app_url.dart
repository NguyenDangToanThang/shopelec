class AppUrl {
  static var baseUrl = 'http://192.168.222.189:8080/v1/api';
  static var registerApiEndPoint = '$baseUrl/register';
  static var getMyInfoEndPoint = '$baseUrl/getInfo';
  static var updateUserEndPoint = '$baseUrl/update';
  static var getAllProductEndPoint = '$baseUrl/product';
  static var getAllCategoryEndPoint = '$baseUrl/category';
  static var getAllBrandEndPoint = '$baseUrl/brand';
  static var getAllCartByUserId = '$baseUrl/cart';
  static var addToCartEndPoint = '$baseUrl/cart/addToCart';
  static var addressEndPoint = '$baseUrl/address';
  static var setActiveAddressEndpoint = '$baseUrl/address/setActive';
  static var deleteAddressEndpoint = '$baseUrl/address/delete';
  static var favoriteEndpoint = '$baseUrl/favorite';
  static var deleteFavoriteEndPoint = '$baseUrl/favorite/delete';
}
