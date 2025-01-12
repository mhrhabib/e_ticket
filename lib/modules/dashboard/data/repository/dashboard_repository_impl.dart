import 'package:dartz/dartz.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/dashboard/data/datasource/dashboard_reomote_data_source.dart';
import 'package:e_ticket/modules/dashboard/data/models/dashboard_model.dart';
import 'package:e_ticket/modules/dashboard/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardReomoteDataSource dashboardRemoteDataSource;
  DashboardRepositoryImpl(this.dashboardRemoteDataSource);
  @override
  Future<Either<Failure, DashboardModel>> getDashboardResponse() async {
    try {
      final response = await dashboardRemoteDataSource.getDashbordData();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
