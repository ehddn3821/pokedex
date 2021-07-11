import 'package:flutter/material.dart';
import 'package:pokedex/managers/db_manager.dart';
import 'package:pokedex/models/pokemon.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('좋아하는 포켓몬')),
        body: FutureBuilder(
          future: DBHelper().getAllPokemon(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Pokemon>> snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data!.length != 0) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Pokemon item = snapshot.data![index];

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          DBHelper().deletePokemon(item.name);
                          setState(() {});
                        },
                        child: Center(child: Text(item.name)),
                      );
                    });
              } else {
                return Center(child: Text('데이터가 없습니다.'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
