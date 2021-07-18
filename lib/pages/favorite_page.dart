import 'package:flutter/material.dart';
import 'package:pokedex/managers/db_manager.dart';
import 'package:pokedex/models/pokemon.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isDelete = false;

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
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon item = snapshot.data![index];
                    int addDescIdx = item.addDesc.length;
                    int pokeNameLength = item.name.length;
                    String pokeName2 =
                        item.name.substring(0, pokeNameLength - addDescIdx);

                    return Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 25,
                              child: Image.network(
                                item.imgUrl,
                              )),
                          Expanded(flex: 3, child: SizedBox(width: 5.0)),
                          Expanded(
                              flex: 62,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pokeName2,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    item.addDesc,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '${item.type} / ${item.species}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 10,
                              child: IconButton(
                                  icon: Icon(Icons.favorite),
                                  color: Colors.red,
                                  onPressed: () {
                                    showAlertDialog(context, item.id);
                                  })),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              } else {
                return Center(child: Text('데이터가 없습니다.'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  showAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("취소"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("확인"),
      onPressed: () {
        setState(() {
          DBHelper().deletePokemon(id);
        });
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("알림"),
      content: Text("정말 좋아요를 취소하시겠습니까?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
