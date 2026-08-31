import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_item.dart';
import 'package:ui_ecommerce/models/cart_controller.dart';
import 'package:ui_ecommerce/pages/checkout_page.dart';

class ItemsPage extends StatefulWidget {
  final String productName;
  final String imagePath;
  final double price;

  const ItemsPage({
    super.key,
    required this.productName,
    required this.imagePath,
    this.price = 65.0,
  });

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  int quantity = 1;

  double get price => widget.price;

  double get subtotal => price * quantity;

  String getCategory() {
    if (widget.productName.contains('Legion') ||
        widget.productName.contains('MSI') ||
        widget.productName.contains('MacBook')) {
      return 'Laptop';
    }

    if (widget.productName.contains('BMW')) {
      return 'Cars';
    }

    return 'Product';
  }

  String getDescription() {
    switch (widget.productName) {
      case 'Legion 5 PRO':
        return 'Powerful gaming laptop with high performance, suitable for gaming, programming, and demanding applications.';

      case 'BMW M4 Competicion':
        return 'A high-performance sports car with an aggressive design and powerful engine, built for an exciting driving experience.';

      case 'MSI Katana GF66':
        return 'Gaming laptop designed for performance with a powerful processor and graphics system for gaming and productivity.';

      case 'MacBook Air M4':
        return 'A lightweight and powerful laptop with modern design, excellent performance, and long-lasting battery life.';

      default:
        return 'High quality product with modern design and excellent performance.';
    }
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  void addToCart() {
    CartController.addItem(
      CartItem(
        name: widget.productName,
        image: widget.imagePath,
        price: price,
        quantity: quantity,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.productName} × $quantity ditambahkan ke keranjang',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ============================================================
  // BUY NOW
  // ============================================================

  void buyNow() {
    final checkoutItem = CartItem(
      name: widget.productName,
      image: widget.imagePath,
      price: price,
      quantity: quantity,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          cartItems: [checkoutItem],
          clearCartAfterOrder: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // TOP BAR
            // ==================================================

            Container(
              height: 65,
              color: const Color(0xFFF7F8FA),

              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.favorite_border,
                      size: 26,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // CONTENT
            // ==================================================

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // PRODUCT IMAGE
                    Container(
                      height: 330,
                      width: double.infinity,
                      color: Colors.white,

                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.contain,

                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 70,
                              color: Color(0xFF9CA3AF),
                            ),
                          );
                        },
                      ),
                    ),

                    // PRODUCT INFORMATION
                    Padding(
                      padding: const EdgeInsets.all(24),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          // NAME
                          Text(
                            widget.productName,

                            style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // CATEGORY + RATING
                          Row(
                            children: [
                              Text(
                                getCategory(),

                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF6B7280),
                                ),
                              ),

                              const SizedBox(width: 15),

                              const Icon(
                                Icons.star,
                                color: Color(0xFFE8B44F),
                                size: 19,
                              ),

                              const SizedBox(width: 5),

                              const Text(
                                '4.8',

                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // PRICE
                          Text(
                            '\$${price.toStringAsFixed(2)}',

                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A5F),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // DESCRIPTION
                          const Text(
                            'Description',

                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            getDescription(),

                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Color(0xFF6B7280),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // COLOR
                          const Text(
                            'Color',

                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,

                                decoration:
                                    BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,

                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),

                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.15),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 12),

                              const Text(
                                'Black',

                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF374151),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // QUANTITY
                          const Text(
                            'Quantity',

                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              _quantityButton(
                                icon: Icons.remove,

                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              ),

                              SizedBox(
                                width: 60,

                                child: Center(
                                  child: Text(
                                    '$quantity',

                                    style:
                                        const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.w500,
                                      color:
                                          Color(0xFF1F2937),
                                    ),
                                  ),
                                ),
                              ),

                              _quantityButton(
                                icon: Icons.add,

                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 35),

                          // SUBTOTAL
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [
                              const Text(
                                'Subtotal',

                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFF1F2937),
                                ),
                              ),

                              Text(
                                '\$${subtotal.toStringAsFixed(2)}',

                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Color(0xFF1E3A5F),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 35),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // BOTTOM BUTTONS
            // ==================================================

            Container(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                20,
              ),

              color: const Color(0xFFF7F8FA),

              child: Row(
                children: [
                  // ADD TO CART
                  Expanded(
                    child: SizedBox(
                      height: 55,

                      child: OutlinedButton.icon(
                        onPressed: addToCart,

                        icon: const Icon(
                          Icons.add_shopping_cart,
                        ),

                        label: const Text(
                          'KERANJANG',
                        ),

                        style:
                            OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color(0xFF1E3A5F),

                          side: const BorderSide(
                            color: Color(0xFF1E3A5F),
                            width: 1.5,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // BUY NOW
                  Expanded(
                    child: SizedBox(
                      height: 55,

                      child: ElevatedButton(
                        onPressed: buyNow,

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF1E3A5F),

                          foregroundColor:
                              Colors.white,

                          elevation: 0,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              15,
                            ),
                          ),
                        ),

                        child: const Text(
                          'CHECKOUT',

                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // QUANTITY BUTTON
  // ============================================================

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(12),

      child: Container(
        width: 45,
        height: 45,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(12),

          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),

        child: Icon(
          icon,
          color: const Color(0xFF1E3A5F),
        ),
      ),
    );
  }
}