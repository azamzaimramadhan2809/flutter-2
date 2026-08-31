import 'cart_item.dart';

class CartController {
  static final List<CartItem> items = [];

  // ============================================================
  // ADD ITEM
  // ============================================================

  static void addItem(CartItem newItem) {
    final index = items.indexWhere(
      (item) => item.name == newItem.name,
    );

    if (index != -1) {
      // Kalau produk sudah ada,
      // tambahkan quantity
      items[index].quantity += newItem.quantity;
    } else {
      items.add(newItem);
    }
  }

  // ============================================================
  // REMOVE ITEM
  // ============================================================

  static void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  // ============================================================
  // INCREASE QUANTITY
  // ============================================================

  static void increaseQuantity(int index) {
    if (index >= 0 && index < items.length) {
      items[index].quantity++;
    }
  }

  // ============================================================
  // DECREASE QUANTITY
  // ============================================================

  static void decreaseQuantity(int index) {
    if (index >= 0 && index < items.length) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      }
    }
  }

  // ============================================================
  // TOTAL
  // ============================================================

  static double get total {
    return items.fold(
      0.0,
      (sum, item) => sum + item.subtotal,
    );
  }

  // ============================================================
  // CLEAR CART
  // ============================================================

  static void clearCart() {
    items.clear();
  }
}