import 'package:e_ticket/modules/tickets/data/models/tickets_model.dart';
import 'package:flutter/material.dart';

class TicketSaleItem extends StatelessWidget {
  final Ticket ticketData;

  const TicketSaleItem({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ticket Route
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticketData.ticketRouteName ?? 'Unknown Route',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "\$${ticketData.price}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // From and To Counters
          Row(
            children: [
              Icon(Icons.arrow_circle_up, size: 20.0, color: Colors.blue),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  "From: ${ticketData.fromTicketCounterName ?? 'Unknown'}",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            children: [
              Icon(Icons.arrow_circle_down, size: 20.0, color: Colors.red),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  "To: ${ticketData.toTicketCounterName ?? 'Unknown'}",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Type and Sale Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Type: ${ticketData.type ?? 'General'}",
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
              Text(
                "Sale Date: ${ticketData.saleDate ?? 'N/A'}",
                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // User Info
          Text(
            "Sold By: ${ticketData.userName ?? 'N/A'}",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
