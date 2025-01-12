import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/dashboard/data/models/dashboard_model.dart';
import 'package:e_ticket/modules/dashboard/domain/repository/dashboard_repository.dart';

class DashboardUsecase {
  final DashboardRepository dashboardRepository;

  DashboardUsecase(this.dashboardRepository);

  Future<Either<Failure, DashboardModel>> execute() {
    return dashboardRepository.getDashboardResponse();
  }
}
