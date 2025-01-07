part of 'ticket_sale_cubit.dart';

sealed class TicketSaleState extends Equatable {
  const TicketSaleState();

  @override
  List<Object> get props => [];
}

final class TicketSaleInitial extends TicketSaleState {}

final class TicketSaleLoading extends TicketSaleState {}

final class TicketSaleListSuccess extends TicketSaleState {
  final TicketsModel ticketsModel;
  const TicketSaleListSuccess(this.ticketsModel);
}

final class TicketSaleSuccess extends TicketSaleState {
  final TicketSaleModel ticketsModel;
  const TicketSaleSuccess(this.ticketsModel);
}

final class TicketSaleFailed extends TicketSaleState {
  final String message;
  const TicketSaleFailed(this.message);
}
