import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../utils/local_storage.dart';

class JokeCard extends StatefulWidget {
  final Joke joke;

  const JokeCard({required this.joke, super.key});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  bool _isFavorite = false;

  String get _jokeText {
    if (widget.joke.type == 'single') {
      return widget.joke.joke ?? '';
    } else {
      return '${widget.joke.setup ?? ''} ${widget.joke.delivery ?? ''}';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final favorites = await LocalStorage.getFavorites();
    setState(() {
      _isFavorite = favorites.contains(_jokeText);
    });
  }

  Future<void> _toggleFavorite() async {
    final favorites = await LocalStorage.getFavorites();
    setState(() {
      if (_isFavorite) {
        favorites.remove(_jokeText);
        _isFavorite = false;
      } else {
        favorites.add(_jokeText);
        _isFavorite = true;
      }
    });
    await LocalStorage.saveFavorites(favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.joke.type == 'single'
                ? Text(widget.joke.joke ?? '')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.joke.setup ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(widget.joke.delivery ?? ''),
                    ],
                  ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(_isFavorite ? Icons.star : Icons.star_border, color: Colors.amber),
                onPressed: _toggleFavorite,
                tooltip: _isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
              ),
            ),
          ],
        ),
      ),
    );
  }
}