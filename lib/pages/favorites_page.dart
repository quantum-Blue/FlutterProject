import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  Future<void> removeFavorite(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites.remove(title);
      prefs.setStringList('favorites', favorites);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favori Kitaplar")),
      drawer: DrawerWidget(),
      body: favorites.isEmpty
          ? Center(child: Text("Hiç favori kitap yok."))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.grey),
              onPressed: () => removeFavorite(favorites[index]),
            ),
          );
        },
      ),
    );
  }
}
