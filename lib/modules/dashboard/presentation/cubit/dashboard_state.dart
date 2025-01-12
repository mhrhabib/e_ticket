part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final DashboardModel dashboardModel;
  const DashboardSuccess(this.dashboardModel);
}

final class DashboardFailed extends DashboardState {
  final String message;
  const DashboardFailed(this.message);
}
