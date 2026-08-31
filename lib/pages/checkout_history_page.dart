import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../services/auth_service.dart';
import '../services/order_service.dart';

class CheckoutHistoryPage extends StatelessWidget {
  const CheckoutHistoryPage({super.key});

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthNames[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService.currentUser;

    final orders = currentUser != null
        ? OrderService.getOrdersForUser(currentUser.email)
        : <OrderHistory>[];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Checkout History',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,
        elevation: 0.5,

        iconTheme: const IconThemeData(color: Color(0xFF1E3A5F)),
      ),

      body: orders.isEmpty ? _emptyState() : _orderList(orders),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Color(0xFF9CA3AF),
          ),

          const SizedBox(height: 15),

          const Text(
            'No checkout history yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF374151),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Your orders will appear here',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _orderList(List<OrderHistory> orders) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,

      itemBuilder: (context, index) {
        final order = orders[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    'Order #${order.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),

                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F5EC),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      order.status,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15803D),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ...order.items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),

                  child: Text(
                    '${item.name}  ×${item.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
              ),

              const Divider(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '${_formatDate(order.dateTime)}  •  ${_formatTime(order.dateTime)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}