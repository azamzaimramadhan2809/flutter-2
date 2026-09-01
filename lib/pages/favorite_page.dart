import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/favorite_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void removeFavorite(String name) {
    setState(() {
      FavoriteController.removeFavorite(name);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name removed from favorites'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteController.getFavorites();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A5F),
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
          ),
        ),

        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: false,
      ),

      body: favorites.isEmpty
          ? _emptyFavorite()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];

                return _favoriteCard(item);
              },
            ),
    );
  }

  // ============================================================
  // EMPTY FAVORITE
  // ============================================================

  Widget _emptyFavorite() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,

              decoration: BoxDecoration(
                color: const Color(0xFFE8E7FF),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.favorite_border,
                size: 50,
                color: Color(0xFF6C63FF),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'No Favorites Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Products you like will appear here.',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FAVORITE CARD
  // ============================================================

  Widget _favoriteCard(FavoriteItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [
            // ==================================================
            // IMAGE
            // ==================================================

            Container(
              width: 100,
              height: 100,

              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(14),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),

                child: Image.asset(
                  item.image,
                  fit: BoxFit.contain,

                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const Icon(
                      Icons.image_outlined,
                      size: 45,
                      color: Color(0xFF9CA3AF),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 15),

            // ==================================================
            // PRODUCT INFORMATION
            // ==================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    item.name,

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 17,
                        color: Color(0xFFE8B44F),
                      ),

                      const SizedBox(width: 5),

                      const Text(
                        '4.8',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '\$${item.price.toStringAsFixed(2)}',

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A5F),
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // REMOVE BUTTON
            // ==================================================

            IconButton(
              onPressed: () {
                removeFavorite(item.name);
              },

              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}