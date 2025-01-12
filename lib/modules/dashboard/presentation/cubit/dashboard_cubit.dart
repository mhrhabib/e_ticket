import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/dashboard/data/models/dashboard_model.dart';
import 'package:e_ticket/modules/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardUsecase dashboardUsecase;
  DashboardCubit({required this.dashboardUsecase}) : super(DashboardInitial()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    emit(DashboardLoading());
    final response = await dashboardUsecase.execute();

    response.fold(
      (failure) => emit(DashboardFailed(_mapFailureToMessage(failure))),
      (state) => emit(DashboardSuccess(state)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
