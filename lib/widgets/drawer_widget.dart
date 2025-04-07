import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrawerWidget extends StatelessWidget {
  Future<String> fetchLogoUrl() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    final data = json.decode(response.body);
    return data['message'];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder<String>(
            future: fetchLogoUrl(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DrawerHeader(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return DrawerHeader(child: Text("Logo yüklenemedi"));
              } else {
                return DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Image.network(snapshot.data!),
                );
              }
            },
          ),
          ListTile(
            title: Text("Ana Sayfa"),
            onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          ListTile(
            title: Text("Favoriler"),
            onTap: () => Navigator.pushReplacementNamed(context, '/favorites'),
          ),
        ],
      ),
    );
  }
}
