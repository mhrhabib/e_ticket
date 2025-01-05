part of 'ticket_type_cubit.dart';

sealed class TicketTypeState extends Equatable {
  const TicketTypeState();

  @override
  List<Object> get props => [];
}

final class TicketTypeInitial extends TicketTypeState {}

final class TicketTypeLoading extends TicketTypeState {}

final class TicketTypeSuccess extends TicketTypeState {
  final List<TicketType> ticketType;
  const TicketTypeSuccess(this.ticketType);
}

final class TicketTypeFailUre extends TicketTypeState {
  final String message;
  const TicketTypeFailUre(this.message);
}
