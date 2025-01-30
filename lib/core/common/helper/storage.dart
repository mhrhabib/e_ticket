import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../modules/tickets/data/models/sale_model.dart';
import '../../../modules/tickets/data/models/ticket_fare_model.dart';

final storage = GetStorage();

Future<void> clearLocalData() async {
  // Clear all data related to the app
  await Hive.box<SaleModel>('sales').clear();
  await Hive.box<TicketFareModel>('fareBox').clear();
  // Add any other boxes or local storage data you want to clear

  // Verify if the boxes are empty
  final salesBoxCount = Hive.box<SaleModel>('sales').length;
  final fareBoxCount = Hive.box<TicketFareModel>('fareBox').length;

  if (salesBoxCount == 0 && fareBoxCount == 0) {
    print("Local data cleared successfully.");
  } else {
    print("Data clearance failed. Sales box count: $salesBoxCount, Fare box count: $fareBoxCount");
  }
}

/// Checks the current internet connection type and returns the result.
Future<String> checkInternetConnectionType() async {
  try {
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();

    if (results.isEmpty) {
      return 'No connectivity results found.';
    }

    // Assuming you want to check the primary connection result
    ConnectivityResult primaryResult = results.first;

    switch (primaryResult) {
      case ConnectivityResult.mobile:
        return 'Mobile data connection is active.';
      case ConnectivityResult.wifi:
        return 'Wi-Fi connection is active.';
      case ConnectivityResult.ethernet:
        return 'Ethernet connection is active.';
      case ConnectivityResult.vpn:
        return 'VPN connection is active.';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth network connection is active.';
      case ConnectivityResult.other:
        return 'Connected to an unknown network type.';
      case ConnectivityResult.none:
        return 'No internet connection available.';
    }
  } catch (e) {
    return 'Error checking internet connection: $e';
  }
}

/// Simplified method to check if there is any internet connection available.
Future<bool> checkInternetConnection() async {
  try {
    List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    return results.isNotEmpty && results.first != ConnectivityResult.none;
  } catch (e) {
    return false;
  }
}

void clearStorage() {
  storage.remove('userId');
  storage.remove('token');
  storage.remove('counterId');
  storage.remove('shortName');
  storage.remove('deviceId');
  storage.remove('fromCounterName');
}
