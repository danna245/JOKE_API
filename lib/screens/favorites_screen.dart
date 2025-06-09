import 'package:flutter/material.dart';
import '../utils/local_storage.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await LocalStorage.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeFavorite(int index) async {
    _favorites.removeAt(index);
    await LocalStorage.saveFavorites(_favorites);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos', style: TextStyle(color: Colors.white)), // Título blanco
        backgroundColor: Colors.deepPurple, // AppBar morada
        iconTheme: const IconThemeData(color: Colors.white), // Flecha de retroceso blanca
      ),
      body: _favorites.isEmpty
          ? const Center(
              child: Text(
                'No tienes chistes favoritos.',
                style: TextStyle(fontSize: 18, color: Colors.deepPurple), // Texto morado
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.deepPurple.shade50, // Fondo de la tarjeta morado claro
                  child: ListTile(
                    leading: const Icon(Icons.emoji_emotions, color: Colors.deepPurple), // Icono morado
                    title: Text(
                      _favorites[index],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.deepPurple), // Texto morado
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Quitar de favoritos',
                      onPressed: () => _removeFavorite(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}