class FavoriteItem {
  final String name;
  final String image;
  final double price;

  FavoriteItem({
    required this.name,
    required this.image,
    required this.price,
  });
}

class FavoriteController {
  static final List<FavoriteItem> favorites = [];

  // Cek apakah product sudah difavorite
  static bool isFavorite(String name) {
    return favorites.any((item) => item.name == name);
  }

  // Tambah favorite
  static void addFavorite(FavoriteItem item) {
    if (!isFavorite(item.name)) {
      favorites.add(item);
    }
  }

  // Hapus favorite
  static void removeFavorite(String name) {
    favorites.removeWhere((item) => item.name == name);
  }

  // Ambil semua favorite
  static List<FavoriteItem> getFavorites() {
    return List.unmodifiable(favorites);
  }

  // Hapus semua favorite
  static void clearFavorites() {
    favorites.clear();
  }
}