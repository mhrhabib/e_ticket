import 'package:e_ticket/modules/config/data/models/price_model.dart';

abstract class TicketPriceState {}

class TicketPriceInitial extends TicketPriceState {}

class TicketPriceLoading extends TicketPriceState {}

class TicketPriceLoaded extends TicketPriceState {
  final PriceModel price;

  TicketPriceLoaded(this.price);
}

class TicketPriceError extends TicketPriceState {
  final String message;

  TicketPriceError(this.message);
}
