class AppUrl {
  //for deploy
  // static var baseUrl = 'https://backend-2-9bjq.onrender.com/v1/api';
  static var baseUrl = 'http://10.0.2.2:8080/v1/api';

  static var registerApiEndPoint = '$baseUrl/register';
  static var getMyInfoEndPoint = '$baseUrl/getInfo';
  static var updateUserEndPoint = '$baseUrl/update';
  static var getAllProductEndPoint = '$baseUrl/product';
  static var getAllCategoryEndPoint = '$baseUrl/category';
  static var getAllBrandEndPoint = '$baseUrl/brand';
  static var getAllCartByUserId = '$baseUrl/cart';
  static var deleteCartByCartId = '$baseUrl/cart/delete';
  static var setQuantityInCart = '$baseUrl/cart/setQuantity';
  static var addToCartEndPoint = '$baseUrl/cart/addToCart';
  static var addressEndPoint = '$baseUrl/address';
  static var setActiveAddressEndpoint = '$baseUrl/address/setActive';
  static var deleteAddressEndpoint = '$baseUrl/address/delete';
  static var favoriteEndpoint = '$baseUrl/favorite';
  static var deleteFavoriteEndPoint = '$baseUrl/favorite/delete';
  static var couponsEndpoint = '$baseUrl/coupons';
  static var orderEndpoint = '$baseUrl/order';
  static var saveStatusDetailEndpoint = '$baseUrl/order/detail/updateStatus';
  static var orderUpdateStatusEndpoint = '$baseUrl/order/updateStatus';
  static var saveOrUpdateTokenFCMEndpoint = '$baseUrl/tokens/update';
  static var saveRateEndpoint = '$baseUrl/review/save';
  static var uploadAvatarEndpoint = '$baseUrl/avatar';
}
