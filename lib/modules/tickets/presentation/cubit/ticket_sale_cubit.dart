import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_fare_model.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_sale_model.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:e_ticket/modules/tickets/domain/usecase/ticket_sale_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_sale_state.dart';

class TicketSaleCubit extends Cubit<TicketSaleState> {
  final TicketSaleUsecase ticketSaleUsecase;

  TicketSaleCubit({required this.ticketSaleUsecase}) : super(TicketSaleInitial()) {
    loadTicketFareList();
  }

  Future<void> loadTicketSaleList() async {
    emit(TicketSaleLoading());
    final response = await ticketSaleUsecase.execute();
    response.fold(
      (failure) => emit(TicketSaleFailed(_mapFailureToMessage(failure))),
      (ticket) => emit(TicketSaleListSuccess(ticket)),
    );
  }

  Future<void> loadTicketFareList() async {
    emit(TicketSaleLoading());
    final response = await ticketSaleUsecase.getTicketFare();
    response.fold(
      (failure) => emit(TicketSaleFailed(_mapFailureToMessage(failure))),
      (ticket) => emit(TicketFareSuccess(ticketFareModel: ticket)),
    );
  }

  Future<void> addTicketSale(
      {required int userId, required int ticketRouteId, required int fromTicketCounterId, required int toTicketCounterId, required String type, required double price, required bool isAdvanced, required int deviceId, String? journeyDate}) async {
    emit(TicketSaleLoading());

    final response = await ticketSaleUsecase.call(
        userId: userId, ticketRouteId: ticketRouteId, fromTicketCounterId: fromTicketCounterId, toTicketCounterId: toTicketCounterId, type: type, price: price, isAdvanced: isAdvanced, deviceId: deviceId, journeyDate: journeyDate!);
    response.fold(
      (failed) => emit(TicketSaleFailed(_mapFailureToMessage(failed))),
      (ticket) => emit(TicketSaleSuccess(ticket)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    } else if (failure is ValidationFailure) {
      return 'Validation Error: ${failure.message}';
    } else if (failure is NetworkFailure) {
      return 'Network Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
