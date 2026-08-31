import 'package:flutter/material.dart';

import 'package:ui_ecommerce/models/cart_item.dart';
import 'package:ui_ecommerce/models/cart_controller.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final int index;
  final VoidCallback onChanged;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 7,
      ),

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(15),

        border: Border.all(
          color: const Color(
            0xFFE5E7EB,
          ),
        ),
      ),

      child: Row(
        children: [
          // ======================================
          // PRODUCT IMAGE
          // ======================================

          Container(
            width: 85,
            height: 85,

            padding:
                const EdgeInsets.all(8),

            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFF7F8FA),

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Image.asset(
              item.image,

              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          // ======================================
          // PRODUCT INFO
          // ======================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  item.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  '\$${item.price.toStringAsFixed(2)}',

                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(0xFF6C63FF),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                // ==================================
                // QUANTITY
                // ==================================

                Row(
                  children: [
                    // MINUS
                    InkWell(
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),

                      onTap: () {
                        CartController
                            .decreaseQuantity(
                          index,
                        );

                        onChanged();
                      },

                      child: Container(
                        width: 30,
                        height: 30,

                        decoration:
                            BoxDecoration(
                          border:
                              Border.all(
                            color:
                                const Color(
                              0xFFE5E7EB,
                            ),
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            8,
                          ),
                        ),

                        child:
                            const Icon(
                          Icons.remove,
                          size: 16,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 45,

                      child: Center(
                        child: Text(
                          '${item.quantity}',

                          style:
                              const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // PLUS
                    InkWell(
                      borderRadius:
                          BorderRadius.circular(
                        8,
                      ),

                      onTap: () {
                        CartController
                            .increaseQuantity(
                          index,
                        );

                        onChanged();
                      },

                      child: Container(
                        width: 30,
                        height: 30,

                        decoration:
                            BoxDecoration(
                          border:
                              Border.all(
                            color:
                                const Color(
                              0xFFE5E7EB,
                            ),
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            8,
                          ),
                        ),

                        child:
                            const Icon(
                          Icons.add,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ======================================
          // DELETE
          // ======================================

          IconButton(
            onPressed: () {
              CartController.removeItem(
                index,
              );

              onChanged();
            },

            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}