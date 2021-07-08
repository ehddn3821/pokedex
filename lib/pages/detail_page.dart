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

  var icon = Icons.favorite_border;
  var isSelected = false;

  @override
  Widget build(BuildContext context) {
    // 포켓몬 이름 인덱스 지정해서 자르기
    var result = searchResult[0];
    int idx = result.name.indexOf('.');
    String pokeId = result.name.substring(0, idx + 5);
    String pokeName1 = result.name.substring(idx + 6);
    int addDescIdx = result.addDesc!.length;
    int pokeNameLength = pokeName1.length;
    String pokeName2 = pokeName1.substring(0, pokeNameLength - addDescIdx);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokeId),
      ),
      body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우 화면크기랑 같게
            children: [
              Image.network(result.imgUrl),
              SizedBox(height: 20.0),
              Text(
                '${result.type} / ${result.group!}',
                style:
                new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokeName2,
                    style: new TextStyle(
                        fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(icon),
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      setState(() {
                        if (isSelected) {
                          isSelected = false;
                          icon = Icons.favorite_border;
                        } else {
                          isSelected = true;
                          icon = Icons.favorite;
                        }
                      });
                    },
                  )
                ],
              ),
              Text(
                result.addDesc!,
                style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              SizedBox(height: 30.0),
              Text(
                result.desc!,
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
