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
    var result = searchResult[0];
    int idx = result.name.indexOf('.');
    String pokeId = result.name.substring(0, idx + 5);
    String pokeName = result.name.substring(idx + 6);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokeId),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우 화면크기랑 같게
            children: [
              Image.network(result.imgUrl),
              SizedBox(height: 20.0),
              Text(pokeName,
                  style: new TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Text(result.addDesc!),
              SizedBox(height: 20.0),
              Text(
                '${result.type} / ${result.group!}',
                style:
                    new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                  result.desc!,
                style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
