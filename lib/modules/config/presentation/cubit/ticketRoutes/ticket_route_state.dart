import 'package:e_ticket/modules/config/data/models/ticket_routes_model.dart';
import 'package:equatable/equatable.dart';

sealed class TicketRouteState extends Equatable {
  const TicketRouteState();

  @override
  List<Object> get props => [];
}

final class TicketRouteInitial extends TicketRouteState {}

final class TicketRouteLoading extends TicketRouteState {}

final class TicketRouteSuccess extends TicketRouteState {
  final List<TicketRoute> ticketRoute;
  const TicketRouteSuccess(this.ticketRoute);
}

final class TicketRouteFailUre extends TicketRouteState {
  final String message;
  const TicketRouteFailUre(this.message);
}
