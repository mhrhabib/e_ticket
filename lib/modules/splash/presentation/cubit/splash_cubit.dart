import 'package:e_ticket/core/common/helper/sale_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SaleService saleService;

  SplashCubit(this.saleService) : super(const SplashInitial());

  Future<void> initializeApp() async {
    emit(const SplashLoading());

    print("Splashh>>>>>>>>>>>>>>>>>>>>>>>>>");

    try {
      // Check if there are sales to post
      final salesList = await saleService.getSalesFromHive();

      if (salesList.isNotEmpty) {
        await saleService.postSales(salesList);
      } else {
        print("Empty sale list **********************");
      }

      // Continue to home or login screen
      emit(const SplashSuccess());
    } catch (e) {
      emit(SplashFailure('Failed to initialize app: $e'));
    }
  }
}
