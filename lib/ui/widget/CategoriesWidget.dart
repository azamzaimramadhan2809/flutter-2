import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final String selectedCategory;

  final Function(String) onCategorySelected;

  const CategoriesWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'All',
        'icon': Icons.apps_rounded,
      },
      {
        'name': 'Laptop',
        'icon': Icons.laptop_rounded,
      },
      {
        'name': 'Handphone',
        'icon': Icons.smartphone_rounded,
      },
      {
        'name': 'TWS',
        'icon': Icons.headphones_rounded,
      },
      {
        'name': 'Mouse',
        'icon': Icons.mouse_rounded,
      },
      {
        'name': 'Mouse Pad',
        'icon': Icons.grid_view_rounded,
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      padding: const EdgeInsets.only(
        left: 10,
      ),

      child: Row(
        children: [
          for (final category in categories)
            GestureDetector(
              onTap: () {
                onCategorySelected(
                  category['name'],
                );
              },

              child: Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),

                padding:
                    const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),

                decoration: BoxDecoration(
                  color:
                      selectedCategory ==
                              category['name']
                          ? const Color(0xFF6C63FF)
                          : Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(
                    color:
                        selectedCategory ==
                                category['name']
                            ? const Color(
                                0xFF6C63FF,
                              )
                            : const Color(
                                0xFFE5E7EB,
                              ),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withValues(
                        alpha: 0.06,
                      ),

                      blurRadius: 6,

                      offset:
                          const Offset(0, 3),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Icon(
                      category['icon'],

                      size: 28,

                      color:
                          selectedCategory ==
                                  category['name']
                              ? Colors.white
                              : const Color(
                                  0xFF1E3A5F,
                                ),
                    ),

                    const SizedBox(
                      width: 9,
                    ),

                    Text(
                      category['name'],

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,

                        color:
                            selectedCategory ==
                                    category['name']
                                ? Colors.white
                                : const Color(
                                    0xFF1E3A5F,
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}