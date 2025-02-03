import 'package:e_ticket/core/common/helper/sale_service.dart';
import 'package:e_ticket/main.dart';
import 'package:e_ticket/modules/splash/data/remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SaleService saleService;

  SplashCubit(
    this.saleService,
  ) : super(const SplashInitial());

  Future<void> initializeApp() async {
    emit(const SplashLoading());

    try {
      // Fetch IMEI from the device
      final deviceIMEI = await getDeviceInfo();

      if (deviceIMEI == null) {
        emit(const SplashFailure('Failed to retrieve device IMEI.'));
        return;
      }

      // Fetch authorized devices from the API
      final authorizedDevices = await RemoteDataSource().getAuthorizedDevices();

      // Check if the device's IMEI is authorized
      final isAuthorized = authorizedDevices.any((device) => device.imei == deviceIMEI);

      if (!isAuthorized) {
        emit(const SplashFailure('Device is not authorized.'));
        return;
      }

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
