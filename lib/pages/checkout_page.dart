import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/cart_controller.dart';
import '../services/auth_service.dart';
import '../services/order_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;

  final bool clearCartAfterOrder;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    this.clearCartAfterOrder = true,
  });

  @override
  State<CheckoutPage> createState() =>
      _CheckoutPageState();
}

class _CheckoutPageState
    extends State<CheckoutPage> {
  final _formKey =
      GlobalKey<FormState>();

  final _addressController =
      TextEditingController();

  String _paymentMethod =
      'Cash on Delivery';

  // ============================================================
  // TOTAL
  // ============================================================

  double get total {
    return widget.cartItems.fold(
      0.0,
      (sum, item) =>
          sum + item.subtotal,
    );
  }

  // ============================================================
  // PRICE
  // ============================================================

  String formatPrice(
    double price,
  ) {
    return '\$${price.toStringAsFixed(2)}';
  }

  // ============================================================
  // PLACE ORDER
  // ============================================================

  void placeOrder() {
    if (!_formKey.currentState!
        .validate()) {
      // ignore: avoid_print
      print('PLACE ORDER GAGAL: form validation failed (misal alamat kosong)');
      return;
    }

    final currentUser = AuthService.currentUser;

    // ignore: avoid_print
    print('PLACE ORDER DIPANGGIL. currentUser = ${currentUser?.email}');

    if (currentUser == null) {
      // ignore: avoid_print
      print('PLACE ORDER GAGAL: currentUser NULL, order TIDAK disimpan.');
    } else {
      OrderService.placeOrder(
        userEmail: currentUser.email,
        items: widget.cartItems,
        total: total,
      );
    }

    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (
        dialogContext,
      ) {
        return AlertDialog(
          title: const Text(
            'Order Placed',
          ),

          content: const Text(
            'Your order has been placed successfully.',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                if (widget
                    .clearCartAfterOrder) {
                  CartController
                      .clearCart();
                }

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Checkout',
        ),

        backgroundColor:
            Colors.white,

        foregroundColor:
            const Color(0xFF1F2937),

        elevation: 0.5,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,

          child:
              SingleChildScrollView(
            padding:
                const EdgeInsets.all(
              20,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Order Summary',

                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                ...widget.cartItems
                    .map(
                  buildOrderItem,
                ),

                const SizedBox(
                  height: 20,
                ),

                Container(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),

                    border:
                        Border.all(
                      color:
                          const Color(
                        0xFFE5E7EB,
                      ),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                    children: [
                      const Text(
                        'Total',

                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      Text(
                        formatPrice(
                          total,
                        ),

                        style:
                            const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(
                            0xFF6C63FF,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 28,
                ),

                const Text(
                  'Shipping Address',

                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                TextFormField(
                  controller:
                      _addressController,

                  minLines: 3,
                  maxLines: 5,

                  decoration:
                      InputDecoration(
                    hintText:
                        'Enter your shipping address',

                    alignLabelWithHint:
                        true,

                    filled: true,

                    fillColor:
                        Colors.white,

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),

                      borderSide:
                          const BorderSide(
                        color:
                            Color(
                          0xFFE5E7EB,
                        ),
                      ),
                    ),
                  ),

                  validator:
                      (value) {
                    if (value ==
                            null ||
                        value
                            .trim()
                            .isEmpty) {
                      return 'Please enter your address.';
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 28,
                ),

                const Text(
                  'Payment Method',

                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                paymentOption(
                  'Cash on Delivery',
                ),

                paymentOption(
                  'Bank Transfer',
                ),

                paymentOption(
                  'Credit / Debit Card',
                ),

                const SizedBox(
                  height: 30,
                ),

                SizedBox(
                  width:
                      double.infinity,

                  height: 52,

                  child:
                      ElevatedButton(
                    onPressed:
                        placeOrder,

                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF1E3A5F,
                      ),

                      foregroundColor:
                          Colors.white,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                      ),
                    ),

                    child:
                        const Text(
                      'PLACE ORDER',

                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderItem(
    CartItem item,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      padding:
          const EdgeInsets.all(
        12,
      ),

      decoration:
          BoxDecoration(
        color:
            Colors.white,

        borderRadius:
            BorderRadius.circular(
          12,
        ),

        border:
            Border.all(
          color:
              const Color(
            0xFFE5E7EB,
          ),
        ),
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              '${item.name} × ${item.quantity}',

              style:
                  const TextStyle(
                fontSize: 15,
                color:
                    Color(
                  0xFF374151,
                ),
              ),

              maxLines: 2,

              overflow:
                  TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          Text(
            formatPrice(
              item.subtotal,
            ),

            style:
                const TextStyle(
              fontSize: 15,
              fontWeight:
                  FontWeight.bold,
              color:
                  Color(
                0xFF1E3A5F,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentOption(
    String value,
  ) {
    return RadioListTile<String>(
      contentPadding:
          EdgeInsets.zero,

      title: Text(
        value,

        style:
            const TextStyle(
          fontSize: 15,
          color:
              Color(0xFF374151),
        ),
      ),

      value: value,

      groupValue:
          _paymentMethod,

      onChanged:
          (value) {
        if (value == null) {
          return;
        }

        setState(() {
          _paymentMethod =
              value;
        });
      },
    );
  }
}