import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_controller.dart';
import 'package:ui_ecommerce/pages/checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = CartController.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,

        elevation: 0.5,

        iconTheme: const IconThemeData(
          color: Color(0xFF1E3A5F),
        ),
      ),

      body: items.isEmpty
          ? _emptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),

                    itemCount: items.length,

                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final item = items[index];

                      return Container(
                        margin:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),

                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        decoration:
                            BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),

                          border: Border.all(
                            color:
                                const Color(
                              0xFFE5E7EB,
                            ),
                          ),
                        ),

                        child: Row(
                          children: [
                            // IMAGE
                            Container(
                              width: 85,
                              height: 85,

                              padding:
                                  const EdgeInsets.all(
                                8,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFFF7F8FA,
                                ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  12,
                                ),
                              ),

                              child: Image.asset(
                                item.image,

                                fit: BoxFit.contain,
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ),

                            // INFORMATION
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [
                                  Text(
                                    item.name,

                                    maxLines: 2,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          Color(
                                        0xFF1F2937,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',

                                    style:
                                        const TextStyle(
                                      fontSize: 14,
                                      color:
                                          Color(
                                        0xFF6B7280,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 8,
                                  ),

                                  Row(
                                    children: [
                                      _smallButton(
                                        icon:
                                            Icons.remove,

                                        onTap: () {
                                          CartController
                                              .decreaseQuantity(
                                            index,
                                          );

                                          refresh();
                                        },
                                      ),

                                      Padding(
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                          horizontal:
                                              14,
                                        ),

                                        child: Text(
                                          '${item.quantity}',

                                          style:
                                              const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      _smallButton(
                                        icon:
                                            Icons.add,

                                        onTap: () {
                                          CartController
                                              .increaseQuantity(
                                            index,
                                          );

                                          refresh();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 8,
                            ),

                            // RIGHT SIDE
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,

                              children: [
                                IconButton(
                                  onPressed: () {
                                    CartController
                                        .removeItem(
                                      index,
                                    );

                                    refresh();
                                  },

                                  icon:
                                      const Icon(
                                    Icons.delete_outline,
                                    color:
                                        Colors.red,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  '\$${item.subtotal.toStringAsFixed(2)}',

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
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ==================================================
                // TOTAL
                // ==================================================

                Container(
                  padding:
                      const EdgeInsets.all(20),

                  decoration:
                      const BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [
                          const Text(
                            'Total',

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          Text(
                            '\$${CartController.total.toStringAsFixed(2)}',

                            style:
                                const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF6C63FF),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    CheckoutPage(
                                  cartItems: List
                                      .from(
                                    CartController
                                        .items,
                                  ),
                                  clearCartAfterOrder:
                                      true,
                                ),
                              ),
                            );
                          },

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                              0xFF6C63FF,
                            ),

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
                            'CHECKOUT',

                            style:
                                TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // ============================================================
  // EMPTY CART
  // ============================================================

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Color(0xFF9CA3AF),
          ),

          const SizedBox(
            height: 15,
          ),

          const Text(
            'Keranjang masih kosong',

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF374151),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          const Text(
            'Yuk pilih produk terlebih dahulu',

            style: TextStyle(
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SMALL BUTTON
  // ============================================================

  Widget _smallButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(8),

      child: Container(
        width: 30,
        height: 30,

        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),

          borderRadius:
              BorderRadius.circular(8),
        ),

        child: Icon(
          icon,
          size: 17,
          color: const Color(0xFF1E3A5F),
        ),
      ),
    );
  }
}