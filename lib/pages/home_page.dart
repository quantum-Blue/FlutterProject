import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> books = [];
  List<String> favorites = [];
  String query = "novel";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFavorites();
    fetchBooks(query);
  }

  Future<void> fetchBooks(String searchQuery) async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$searchQuery&maxResults=15'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List items = data['items'];

      setState(() {
        books = items.map<Map<String, String>>((item) {
          final volumeInfo = item['volumeInfo'];
          return {
            'title': volumeInfo['title'] ?? 'No Title',
            'author': (volumeInfo['authors'] != null)
                ? (volumeInfo['authors'] as List).join(', ')
                : 'Unknown Author',
            'thumbnail': volumeInfo['imageLinks'] != null
                ? volumeInfo['imageLinks']['thumbnail']
                : '',
          };
        }).toList();
      });
    } else {
      throw Exception('Kitaplar alınamadı');
    }
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> toggleFavorite(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favorites.contains(title)) {
        favorites.remove(title);
      } else {
        favorites.add(title);
      }
      prefs.setStringList('favorites', favorites);
    });
  }

  void onSearchSubmitted(String value) {
    setState(() {
      query = value;
    });
    fetchBooks(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kitaplar")),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onSubmitted: onSearchSubmitted,
              decoration: InputDecoration(
                hintText: 'Kitap ara... (örn: Flutter, tarih, roman)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  leading: book['thumbnail'] != null && book['thumbnail']!.isNotEmpty
                      ? Image.network(book['thumbnail']!, width: 50)
                      : Icon(Icons.book),
                  title: Text(book['title']!),
                  subtitle: Text(book['author']!),
                  trailing: IconButton(
                    icon: Icon(
                      favorites.contains(book['title'])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favorites.contains(book['title']) ? Colors.red : null,
                    ),
                    onPressed: () => toggleFavorite(book['title']!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
