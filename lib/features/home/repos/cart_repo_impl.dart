import 'package:dio/dio.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:e_commerce/features/home/models/cart_model.dart';
import 'cart_repo.dart';

class CartRepoImpl implements CartRepo {
  final dio = Dio();

  @override
  Future<List<CartModel>> getCartItems() async {
    final token = Prefs.getString('token');
    final response = await dio.get(
      '${kBaseUrl}Cart/basket',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final data = response.data as List;
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  @override
  Future<List<CartModel>> addToCart(CartModel item) async {
    final token = Prefs.getString('token');
    final response = await dio.post(
      '${kBaseUrl}Cart/basket',
      data: [item.toJson()],
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final data = response.data as List;
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  @override
  Future<void> deleteCartItem(int id) async {
    final token = Prefs.getString('token');
    await dio.delete(
      '${kBaseUrl}Cart/basket/item/$id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<void> updateQuantity(CartModel item) async {
    final token = Prefs.getString('token');
    await dio.post(
      '${kBaseUrl}Cart/basket',
      data: [item.toJson()],
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  @override
  Future<String> getBasketId() async {
    final token = Prefs.getString('token');
    final response = await dio.get(
      '${kBaseUrl}Cart/basket/id',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data as String;
  }
}
