import 'package:flutter/material.dart';
import '../services/joke_api_service.dart';
import '../models/joke.dart';
import '../widgets/joke_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final JokeApiService _apiService = JokeApiService();
  Joke? _joke;
  bool _loading = false;
  String _query = '';
  String? _error;

  void _fetchJoke() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final joke = await _apiService.fetchJoke(query: _query.isNotEmpty ? _query : null);
    setState(() {
      _joke = joke;
      _loading = false;
      if (joke == null) _error = 'No se pudo obtener el chiste.';
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JokeAPI App', style: TextStyle(color: Colors.white)), 
        backgroundColor: Colors.deepPurple, 
        actions: [
          IconButton(
            icon: const Icon(Icons.star, color: Colors.white), 
            tooltip: 'Ver favoritos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Buscar chiste',
                labelStyle: TextStyle(color: Colors.deepPurple), 
                focusedBorder: OutlineInputBorder( 
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.deepPurple), 
                  onPressed: _fetchJoke,
                ),
              ),
              onChanged: (value) => _query = value,
              onSubmitted: (_) => _fetchJoke(),
            ),
            const SizedBox(height: 20),
            if (_loading)
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)) 
            else if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red))
            else if (_joke != null)
              JokeCard(joke: _joke!)
            else
              const Text('No se encontró ningún chiste.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchJoke,
        backgroundColor: Colors.deepPurple, 
        child: const Icon(Icons.refresh, color: Colors.white), 
      ),
    );
  }
}