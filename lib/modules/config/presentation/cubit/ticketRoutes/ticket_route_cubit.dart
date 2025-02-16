import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';
import 'package:e_ticket/modules/config/domain/usecases/get_ticket_routes_usecase.dart';
import 'package:e_ticket/modules/config/presentation/cubit/ticketRoutes/ticket_route_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketRouteCubit extends Cubit<TicketRouteState> {
  final GetTicketRoutesUsecase getTicketRoutesUsecase;

  TicketRouteCubit(this.getTicketRoutesUsecase) : super(TicketRouteInitial());

  Future<void> loadTicketRoutes() async {
    emit(TicketRouteLoading());
    final ticketRoutes = await getTicketRoutesUsecase.execute();

    ticketRoutes.fold(
      (failure) => emit(
        TicketRouteFailUre(_mapFailureToMessage(failure)),
      ),
      (tickets) => emit(TicketRouteSuccess(tickets, null)),
    );
  }

  void selectRoute(TicketRoute selectedRoute) {
    if (state is TicketRouteSuccess) {
      final currentState = state as TicketRouteSuccess;
      emit(TicketRouteSuccess(currentState.ticketRoutes, selectedRoute)); // Update selectedUser
    }
  }

  void resetRoute() {
    emit(TicketRouteInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
