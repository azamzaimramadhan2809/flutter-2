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

    // ignore: avoid_print
    print(
      'ORDER SAVED -> id: ${order.id}, user: ${order.userEmail}, total: ${order.total}, totalOrdersNow: ${_orders.length}',
    );

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

    // ignore: avoid_print
    print(
      'FETCHING HISTORY -> for: $normalizedEmail, found: ${result.length} (total in store: ${_orders.length})',
    );

    return result.reversed.toList();
  }
}