import 'package:e_ticket/core/errors/failure.dart';
import 'package:e_ticket/modules/tickets/data/models/ticket_sale_model.dart';
import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:e_ticket/modules/tickets/domain/usecase/ticket_sale_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/ticket_fare_model.dart';
part 'ticket_sale_state.dart';

class TicketSaleCubit extends Cubit<TicketSaleState> {
  final TicketSaleUsecase ticketSaleUsecase;
  late Box<TicketFareModel> fareBox;

  TicketSaleCubit({required this.ticketSaleUsecase}) : super(TicketSaleInitial()) {
    fareBox = Hive.box<TicketFareModel>('fareBox');
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

  /// Load Ticket Fare List
  Future<void> loadTicketFareList() async {
    emit(TicketSaleLoading());

    try {
      // Attempt to load cached data
      final ticketFareModel = fareBox.get('fareData');

      if (ticketFareModel != null) {
        emit(TicketFareSuccess(ticketFareModel: ticketFareModel));
      }

      // Fetch the latest data
      final response = await ticketSaleUsecase.getTicketFare();
      response.fold(
        (failure) {
          emit(TicketSaleFailed(_mapFailureToMessage(failure)));
        },
        (fetchedFare) {
          fareBox.put('fareData', fetchedFare); // Save the latest data to Hive
          emit(TicketFareSuccess(ticketFareModel: fetchedFare));
        },
      );
    } catch (e) {
      emit(TicketSaleFailed('Error loading fare data: $e'));
    }
  }

  Future<void> addTicketSale({
    required int userId,
    required int ticketRouteId,
    required int fromTicketCounterId,
    required int toTicketCounterId,
    required String type,
    required double price,
    required bool isAdvanced,
    required int deviceId,
    String? journeyDate,
  }) async {
    emit(TicketSaleLoading());

    final response = await ticketSaleUsecase.call(
      userId: userId,
      ticketRouteId: ticketRouteId,
      fromTicketCounterId: fromTicketCounterId,
      toTicketCounterId: toTicketCounterId,
      type: type,
      price: price,
      isAdvanced: isAdvanced,
      deviceId: deviceId,
      journeyDate: journeyDate!,
    );
    response.fold(
      (failure) => emit(TicketSaleFailed(_mapFailureToMessage(failure))),
      (ticket) {
        emit(TicketSaleSuccess(ticket));
        // Reset to initial state after emitting success
        emit(TicketSaleInitial());
      },
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
