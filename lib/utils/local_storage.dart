import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _favoritesKey = 'favorite_jokes';

  // Guarda la lista de chistes favoritos (como lista de strings)
  static Future<void> saveFavorites(List<String> jokes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, jokes);
  }

  // Obtiene la lista de chistes favoritos
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }
}