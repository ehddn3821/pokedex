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
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - 15) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(title: Text('검색 결과')),
        body: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(searchResults.length, (index) {
              return Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Image.network(searchResults[index].imgUrl), // 이미지
                    Text(
                      // 이름
                      '${searchResults[index].name}',
                      style: new TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      // 타입
                      '${searchResults[index].type} 타입',
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 12),
                    Text('${searchResults[index].desc}') // 부가 설명
                  ],
                ),
              );
            })));
  }
}
