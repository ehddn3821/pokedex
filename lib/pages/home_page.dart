import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/models/poke.dart';
import 'package:http/http.dart' as http;

Future<Poke> fetchPoke() async {
  final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon-species/12'));

  if (response.statusCode == 200) {
    return Poke.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load pokemon');
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder<Poke>(
        future: fetchPoke(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.names[2].name);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}