import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/calculate_ticket_price_usecase.dart';
import 'ticket_price_state.dart';

class TicketPriceCubit extends Cubit<TicketPriceState> {
  final CalculateTicketPriceUseCase calculateTicketPriceUseCase;

  TicketPriceCubit(this.calculateTicketPriceUseCase) : super(TicketPriceInitial());

  void fetchTicketPrice({
    required String userId,
    required String ticketRouteId,
    required String toCounterId,
    required String type,
  }) async {
    emit(TicketPriceLoading());
    try {
      final price = await calculateTicketPriceUseCase(
        userId: userId,
        ticketRouteId: ticketRouteId,
        toCounterId: toCounterId,
        type: type,
      );
      emit(TicketPriceLoaded(price));
    } catch (e) {
      emit(TicketPriceError('Failed to fetch ticket price: $e'));
    }
  }

  void resetPrice() {
    emit(TicketPriceInitial());
  }
}
