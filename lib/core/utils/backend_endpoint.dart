class BackendEndpoint {
  static const addUserData = 'users';
  static const getUserData = 'users';
  static const isUserExists = 'users';
  static String getProducts({int pageIndex = 1, int pageSize = 10}) {
    return 'Product/ProductsCards?PageIndex=$pageIndex&PageSize=$pageSize';
  }

  static const addOrder = 'orders';
}

//static const String baseUrl = 'https://api.escuelajs.com/api/v1/';
