import 'package:e_ticket/modules/config/domain/usecases/get_ticket_type_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failure.dart';
import '../../../data/models/ticket_type_model.dart';
import 'package:equatable/equatable.dart';
part 'ticket_type_state.dart';

class TicketTypeCubit extends Cubit<TicketTypeState> {
  final GetTicketTypeUsecase getTicketTypeUsecase;
  TicketTypeCubit(this.getTicketTypeUsecase) : super(TicketTypeInitial());

  Future<void> loadTicketTypes() async {
    emit(TicketTypeInitial());

    final ticketTypes = await getTicketTypeUsecase.execute();
    ticketTypes.fold(
      (failure) => emit(TicketTypeFailUre(_mapFailureToMessage(failure))),
      (tickets) => emit(TicketTypeSuccess(tickets)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error: ${failure.message}';
    }
    return 'Unexpected Error';
  }
}
