part of 'add_product_dashboard_cubit.dart';

@immutable
sealed class AddProductDashboardState {}

final class AddProductCubitInitial extends AddProductDashboardState {}

final class AddProductLoading extends AddProductDashboardState {}

final class AddProductSuccess extends AddProductDashboardState {}

final class AddProductFailure extends AddProductDashboardState {
  final String errMessage;
  AddProductFailure(this.errMessage);
}
