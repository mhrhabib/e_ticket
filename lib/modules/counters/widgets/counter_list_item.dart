import 'package:e_ticket/modules/config/data/models/counter_model.dart';
import 'package:flutter/material.dart';

class CounterListItem extends StatelessWidget {
  final Counter data;

  const CounterListItem({super.key, required this.data});

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
            color: Colors.grey.shade600,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text(
            data.name ?? 'Unknown',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),

          // Address
          Text(
            data.address ?? 'No Address Available',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8.0),

          // Status
          Row(
            children: [
              Text(
                "Status: ",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                data.status ?? 'N/A',
                style: TextStyle(
                  fontSize: 14.0,
                  color: data.status == 'Active' ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Timestamp
          Text(
            "Updated At: ${data.updatedAt ?? 'N/A'}",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
