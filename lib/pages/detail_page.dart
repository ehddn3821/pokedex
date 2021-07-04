import "package:flutter/material.dart";
import 'package:pokedex/models/pokemon.dart';

class DetailPage extends StatefulWidget {
  var searchResult = <SearchResult>[];

  DetailPage({required this.searchResult});

  @override
  _DetailState createState() => _DetailState(searchResult);
}

class _DetailState extends State<DetailPage> {
  var searchResult = <SearchResult>[];

  _DetailState(this.searchResult);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(child: Text("${searchResult[0].name}")),
    );
  }
}
