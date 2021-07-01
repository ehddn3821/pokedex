import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class SearchResultPage extends StatefulWidget {

  var searchResults = <SearchResult>[];

  SearchResultPage({required this.searchResults});

  @override
  _SearchResultPageState createState() => _SearchResultPageState(searchResults);
}

class _SearchResultPageState extends State<SearchResultPage> {

  var searchResults = <SearchResult>[];
  _SearchResultPageState(this.searchResults);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('검색 결과')
      ),
      body: ListView.separated(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${searchResults[index].name}')
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}