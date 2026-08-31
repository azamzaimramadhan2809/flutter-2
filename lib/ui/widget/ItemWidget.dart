import 'package:flutter/material.dart';

import 'package:ui_ecommerce/pages/items_page.dart';

import 'package:ui_ecommerce/models/cart_item.dart';
import 'package:ui_ecommerce/models/cart_controller.dart';

class ItemWidget extends StatelessWidget {
  final String selectedCategory;
  final String searchQuery;

  const ItemWidget({
    super.key,
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      // ==================================================
      // LAPTOP
      // ==================================================

      {
        'name': 'Lenovo Legion 5 PRO',
        'image': 'assets/images/items/1.png',
        'rating': 4.8,
        'price': 65.00,
        'category': 'Laptop',
        'description':
            'Powerful gaming laptop with high performance for gaming and programming.',
      },

      {
        'name': 'MSI Katana GF66',
        'image': 'assets/images/items/2.png',
        'rating': 4.7,
        'price': 72.00,
        'category': 'Laptop',
        'description':
            'Gaming laptop with powerful performance for gaming and productivity.',
      },

      // ==================================================
      // HANDPHONE
      // ==================================================

      {
        'name': 'iPhone 16 Pro',
        'image': 'assets/images/items/3.png',
        'rating': 4.9,
        'price': 999.00,
        'category': 'Handphone',
        'description':
            'Premium smartphone with powerful performance and modern design.',
      },

      {
        'name': 'Samsung Galaxy S25',
        'image': 'assets/images/items/4.png',
        'rating': 4.8,
        'price': 899.00,
        'category': 'Handphone',
        'description':
            'Modern smartphone with excellent display and powerful performance.',
      },

      // ==================================================
      // TWS
      // ==================================================

      {
        'name': 'AirPods Pro 2',
        'image': 'assets/images/items/5.png',
        'rating': 4.9,
        'price': 249.00,
        'category': 'TWS',
        'description':
            'Premium wireless earbuds with active noise cancellation.',
      },

      {
        'name': 'Galaxy Buds 3 Pro',
        'image': 'assets/images/items/6.png',
        'rating': 4.7,
        'price': 199.00,
        'category': 'TWS',
        'description':
            'Wireless earbuds with immersive sound and comfortable design.',
      },

      // ==================================================
      // MOUSE
      // ==================================================

      {
        'name': 'Logitech G Pro X Superlight',
        'image': 'assets/images/items/7.png',
        'rating': 4.8,
        'price': 129.00,
        'category': 'Mouse',
        'description':
            'Lightweight gaming mouse designed for competitive gaming.',
      },

      {
        'name': 'Razer DeathAdder V3',
        'image': 'assets/images/items/8.png',
        'rating': 4.7,
        'price': 89.00,
        'category': 'Mouse',
        'description':
            'Ergonomic gaming mouse with accurate tracking and fast response.',
      },

      // ==================================================
      // MOUSE PAD
      // ==================================================

      {
        'name': 'Razer Gigantus V2',
        'image': 'assets/images/items/9.png',
        'rating': 4.6,
        'price': 35.00,
        'category': 'Mouse Pad',
        'description':
            'Large gaming mouse pad with smooth and comfortable surface.',
      },

      {
        'name': 'Logitech G840 XL',
        'image': 'assets/images/items/10.png',
        'rating': 4.7,
        'price': 39.00,
        'category': 'Mouse Pad',
        'description':
            'Extended mouse pad designed for gaming setups.',
      },
    ];

    // ==================================================
    // FILTER
    // ==================================================

    final filteredProducts =
        products.where((product) {
      final String name =
          product['name'].toString().toLowerCase();

      final String category =
          product['category'].toString();

      // CATEGORY FILTER
      final bool categoryMatch =
          selectedCategory == 'All' ||
          category == selectedCategory;

      // SEARCH FILTER
      final bool searchMatch =
          searchQuery.isEmpty ||
          name.contains(
            searchQuery.toLowerCase(),
          );

      return categoryMatch && searchMatch;
    }).toList();

    // ==================================================
    // NO RESULT
    // ==================================================

    if (filteredProducts.isEmpty) {
      return Container(
        width: double.infinity,

        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),

        padding: const EdgeInsets.all(30),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,

              size: 55,

              color: Color(0xFF9CA3AF),
            ),

            const SizedBox(
              height: 12,
            ),

            const Text(
              'Product Not Found',

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Text(
              searchQuery.isNotEmpty
                  ? 'No product matches "$searchQuery".'
                  : 'No product available in this category.',

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      );
    }

    // ==================================================
    // PRODUCT GRID
    // ==================================================

    return GridView.builder(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
      ),

      physics:
          const NeverScrollableScrollPhysics(),

      shrinkWrap: true,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,

        crossAxisSpacing: 10,

        mainAxisSpacing: 12,

        childAspectRatio: 0.72,
      ),

      itemCount:
          filteredProducts.length,

      itemBuilder:
          (context, index) {
        final product =
            filteredProducts[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (context) {
                  return ItemsPage(
                    productName:
                        product['name'],

                    imagePath:
                        product['image'],
                  );
                },
              ),
            );
          },

          child: Container(
            clipBehavior:
                Clip.antiAlias,

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

              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black
                          .withValues(
                    alpha: 0.04,
                  ),

                  blurRadius: 6,

                  offset:
                      const Offset(0, 2),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // ========================================
                // IMAGE
                // ========================================

                Expanded(
                  flex: 6,

                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.white,

                          padding:
                              const EdgeInsets.all(
                            12,
                          ),

                          child:
                              Image.asset(
                            product['image'],

                            fit: BoxFit.contain,

                            errorBuilder:
                                (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return const Center(
                                child:
                                    Text(
                                  'Admin hasn\'t uploaded\n'
                                  'a product photo yet.',

                                  textAlign:
                                      TextAlign.center,

                                  style:
                                      TextStyle(
                                    fontSize:
                                        12,

                                    color:
                                        Color(
                                      0xFF9CA3AF,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // ====================================
                      // FAVORITE
                      // ====================================

                      Positioned(
                        top: 8,
                        right: 8,

                        child:
                            Container(
                          width: 34,
                          height: 34,

                          decoration:
                              const BoxDecoration(
                            color:
                                Colors.white,

                            shape:
                                BoxShape.circle,
                          ),

                          child:
                              const Icon(
                            Icons
                                .favorite_border,

                            size: 19,

                            color:
                                Color(
                              0xFF6B7280,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ========================================
                // INFORMATION
                // ========================================

                Expanded(
                  flex: 3,

                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(
                      12,
                      8,
                      10,
                      10,
                    ),

                    child:
                        Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          product['name'],

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              const TextStyle(
                            fontSize: 15,

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

                        Row(
                          children: [
                            const Icon(
                              Icons.star,

                              size: 15,

                              color:
                                  Color(
                                0xFFFFB800,
                              ),
                            ),

                            const SizedBox(
                              width: 4,
                            ),

                            Text(
                              product['rating']
                                  .toString(),

                              style:
                                  const TextStyle(
                                fontSize: 13,

                                color:
                                    Color(
                                  0xFF6B7280,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [
                            Text(
                              '\$${product['price'].toStringAsFixed(2)}',

                              style:
                                  const TextStyle(
                                fontSize: 16,

                                fontWeight:
                                    FontWeight.bold,

                                color:
                                    Color(
                                  0xFF6C63FF,
                                ),
                              ),
                            ),

                            // =================================
                            // CART
                            // =================================

                            InkWell(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                9,
                              ),

                              onTap: () {
                                CartController
                                    .addItem(
                                  CartItem(
                                    name:
                                        product[
                                            'name'],

                                    image:
                                        product[
                                            'image'],

                                    price:
                                        product[
                                            'price'],
                                  ),
                                );

                                ScaffoldMessenger
                                    .of(
                                  context,
                                ).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(
                                      '${product['name']} added to cart',
                                    ),

                                    duration:
                                        const Duration(
                                      seconds:
                                          1,
                                    ),
                                  ),
                                );
                              },

                              child:
                                  Container(
                                width: 34,
                                height: 34,

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                    0xFF6C63FF,
                                  ).withValues(
                                    alpha:
                                        0.10,
                                  ),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    9,
                                  ),
                                ),

                                child:
                                    const Icon(
                                  Icons
                                      .add_shopping_cart,

                                  size: 18,

                                  color:
                                      Color(
                                    0xFF6C63FF,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}