class Joke {
  final String? category;
  final String? type;
  final String? joke;
  final String? setup;
  final String? delivery;

  Joke({this.category, this.type, this.joke, this.setup, this.delivery});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      category: json['category'],
      type: json['type'],
      joke: json['joke'],
      setup: json['setup'],
      delivery: json['delivery'],
    );
  }
}