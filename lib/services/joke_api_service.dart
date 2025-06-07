import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class JokeApiService {
  static const String _baseUrl = 'https://jokeapi-v2.p.rapidapi.com/joke/Any';
  static const Map<String, String> _headers = {
    'X-RapidAPI-Key': '1effe6087fmsh7c91540e1c68ce3p1a983ejsn59988080b42b',
    'X-RapidAPI-Host': 'jokeapi-v2.p.rapidapi.com',
  };

  Future<Joke?> fetchJoke({String? query}) async {
    final url = Uri.parse(_baseUrl + (query != null && query.isNotEmpty ? '?contains=$query' : ''));
    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        return Joke.fromJson(json.decode(response.body));
      }
    } catch (e) {
      // Manejo de errores
      return null;
    }
    return null;
  }
}