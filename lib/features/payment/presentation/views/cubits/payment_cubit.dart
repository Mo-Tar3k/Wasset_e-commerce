import 'package:e_commerce/features/payment/presentation/views/data/models/repos/payment_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo _paymentRepo;

  PaymentCubit(this._paymentRepo) : super(PaymentInitial());

  Future<void> processPayment({
    required String basketId,
    required String token,
    required Map<String, dynamic> shippingInfo,
  }) async {
    print("🔐 TOKEN USED: $token");

    print("🚀 Entered processPayment()");
    emit(PaymentLoading());

    try {
      final clientSecret = await _paymentRepo.createPaymentIntent(
        basketId,
        token,
      );

      final paymentResult = await _paymentRepo.confirmPayment(clientSecret);

      if (paymentResult) {
        await _paymentRepo.createOrder(token, shippingInfo);
        await _paymentRepo.clearBasket(token);
        emit(PaymentSuccess());
      } else {
        emit(PaymentFailure('Payment failed'));
      }
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
