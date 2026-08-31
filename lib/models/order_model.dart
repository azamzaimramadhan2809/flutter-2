class OrderItem {
  final String name;
  final int quantity;
  final double subtotal;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.subtotal,
  });
}

class OrderHistory {
  final String id;
  final String userEmail;
  final List<OrderItem> items;
  final double total;
  final DateTime dateTime;
  final String status;

  OrderHistory({
    required this.id,
    required this.userEmail,
    required this.items,
    required this.total,
    required this.dateTime,
    this.status = 'Completed',
  });
}