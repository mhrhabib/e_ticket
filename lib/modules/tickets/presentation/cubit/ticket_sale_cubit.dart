import 'package:bloc/bloc.dart';
import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:e_ticket/modules/tickets/domain/usecase/ticket_sale_usecase.dart';
import 'package:equatable/equatable.dart';

part 'ticket_sale_state.dart';

class TicketSaleCubit extends Cubit<TicketSaleState> {
  final TicketSaleUsecase ticketSaleUsecase;

  TicketSaleCubit({required this.ticketSaleUsecase}) : super(TicketSaleInitial());

  Future<void> loadTicketSaleList() async {
    emit(TicketSaleLoading());
    final response = await ticketSaleUsecase.execute();
    response.fold(
      (failure) => emit(TicketSaleFailed(_mapFailureToMessage(failure))),
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
