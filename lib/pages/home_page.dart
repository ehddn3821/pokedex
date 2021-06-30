import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var nameList = <String>[];
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Color(0xffffffff),  // 로고 이미지와 배경색 같게
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // 상하 중앙정렬
        crossAxisAlignment: CrossAxisAlignment.stretch,  // 좌우 화면크기랑 같게
        children: [
          Image(image: AssetImage('images/logo.png')),
          TextField(
            controller: myController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '포켓몬 이름이나 번호, 타입 등을 입력해보세요.',
            )
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child:Icon(Icons.search),
            onPressed: initPokeScrap,
          ),
          SizedBox(height: 20),
          Text('$nameList')
        ],
      ),
    );
  }

  // Web Scraper
  void initPokeScrap() async {
    final webScraper = WebScraper('https://www.pokemonkorea.co.kr');
    final searchText = myController.text;
    // 검색값이 있을때만
    if (searchText != '') {
      final endpoint = '/pokedex?word=$searchText';
      if (await webScraper.loadWebPage(endpoint)) {
        final nameElements = webScraper.getElement(
            '#pokedexlist > li > a > div.bx-txt > h3',
            []
        );
        final nameList = <String>[];
        nameElements.forEach((element) {
          final name = element['title'];
          nameList.add('$name');
        });
        if (mounted)
          setState(() {
            this.nameList = nameList;
          });
      }
    }
  }
}