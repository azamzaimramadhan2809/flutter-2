import '../models/cart_item.dart';
import '../models/order_model.dart';

class OrderService {
  static final List<OrderHistory> _orders = [];
  static int _counter = 0;

  // ============================================================
  // PLACE ORDER
  // ============================================================

  static OrderHistory placeOrder({
    required String userEmail,
    required List<CartItem> items,
    required double total,
  }) {
    _counter++;

    final order = OrderHistory(
      id: _counter.toString().padLeft(3, '0'),
      userEmail: userEmail.trim().toLowerCase(),
      items: items
          .map(
            (item) => OrderItem(
              name: item.name,
              quantity: item.quantity,
              subtotal: item.subtotal,
            ),
          )
          .toList(),
      total: total,
      dateTime: DateTime.now(),
    );

    _orders.add(order);

    return order;
  }

  // ============================================================
  // GET ORDERS FOR USER
  // ============================================================

  static List<OrderHistory> getOrdersForUser(String email) {
    final normalizedEmail = email.trim().toLowerCase();

    final result = _orders
        .where((order) => order.userEmail == normalizedEmail)
        .toList();

    // Terbaru ditampilkan di atas
    return result.reversed.toList();
  }
}