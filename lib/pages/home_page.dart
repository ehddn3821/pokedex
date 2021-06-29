import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var nameList = <String>[];

  @override
  void initState() {
    super.initState();
    initPokeScrap();
  }

  @override
  Widget build(BuildContext context) {

    return Center(child: Text('$nameList'));
  }

  void initPokeScrap() async {
    final webScraper = WebScraper('https://www.pokemonkorea.co.kr');
    final endpoint = '/pokedex?word=2';
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