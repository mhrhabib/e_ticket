import 'package:e_ticket/app/di.dart';
import 'package:e_ticket/core/utils/colors_palate.dart';
import 'package:e_ticket/modules/tickets/presentation/cubit/ticket_sale_cubit.dart';
import 'package:e_ticket/modules/tickets/presentation/pages/widgets/ticket_sale_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsSaleListPage extends StatelessWidget {
  const TicketsSaleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalate.primaryColor,
        title: Text(
          "Ticket sales list",
          style: TextStyle(color: ColorsPalate.onPrimaryColor),
        ),
      ),
      body: BlocBuilder<TicketSaleCubit, TicketSaleState>(
        bloc: TicketSaleCubit(ticketSaleUsecase: sl())..loadTicketSaleList(),
        builder: (context, state) {
          if (state is TicketSaleLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsPalate.primaryColor,
              ),
            );
          }
          if (state is TicketSaleFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is TicketSaleListSuccess) {
            return ListView.builder(
                itemCount: state.ticketsModel.data!.data!.length,
                itemBuilder: (context, index) {
                  return TicketSaleItem(ticketData: state.ticketsModel.data!.data![index]);
                });
          }
          return Text('data');
        },
      ),
    );
  }
}
