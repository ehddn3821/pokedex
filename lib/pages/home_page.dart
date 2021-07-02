import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/search_result_page.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();

  var searchResults = <SearchResult>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Color(0xffffffff), // 로고 이미지와 배경색 같게
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 상하 중앙정렬
            crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우 화면크기랑 같게
            children: [
              Image(image: AssetImage('images/logo.png')),
              TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '포켓몬 이름이나 번호, 타입 등을 입력해보세요.',
                  ),
                  onSubmitted: (value) {
                    if (myController.text.isNotEmpty) {
                      initPokeScrap();
                      Future.delayed(
                          Duration(milliseconds: 300),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultPage(
                                      searchResults: searchResults))));
                    } else {
                      showToast('검색어를 입력해주세요.');
                    }
                  }),
              SizedBox(height: 10),
              FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () {
                    if (myController.text.isNotEmpty) {
                      initPokeScrap();
                      Future.delayed(
                          Duration(milliseconds: 300),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultPage(
                                      searchResults: searchResults))));
                    } else {
                      showToast('검색어를 입력해주세요.');
                    }
                  })
            ],
          ),
        ));
  }

  // Web Scraper
  void initPokeScrap() async {
    final webScraper = WebScraper('https://www.pokemonkorea.co.kr');
    final searchText = myController.text;

    final endpoint = '/pokedex?word=$searchText';
    if (await webScraper.loadWebPage(endpoint)) {
      // 이전 검색값 초기화
      searchResults = <SearchResult>[];

      // 포켓몬 이름
      final nameElements =
          webScraper.getElement('#pokedexlist > li > a > div.bx-txt > h3', []);
      final searchNames = <String>[];
      nameElements.forEach((element) {
        final name = element['title'];
        searchNames.add(name);
      });

      // 포켓몬 사진
      final imgUrlElements = webScraper.getElementAttribute(
          '#pokedexlist > li > a > div.img > div > img', 'src');
      final searchImgUrls = <String>[];
      imgUrlElements.forEach((element) {
        final imgUrl = element;
        searchImgUrls.add(imgUrl!);
      });

      // 포켓몬 타입
      final typeElements = webScraper
          .getElement('#pokedexlist > li > a > div.bx-txt > span', []);
      final searchType = <String>[];
      typeElements.forEach((element) {
        final type = element['title'];
        searchType.add(type);
      });

      // 포켓몬 추가 설명
      final descElements =
          webScraper.getElement('#pokedexlist > li > a > div.bx-txt > p', []);
      final searchDesc = <String>[];
      descElements.forEach((element) {
        final desc = element['title'];
        searchDesc.add(desc);
      });

      for (int i = 0; i < searchNames.length; i++) {
        searchResults.add(SearchResult(
            searchNames[i], searchImgUrls[i], searchType[i], searchDesc[i]));
      }

      if (mounted) {
        setState(() {
          this.searchResults = searchResults;
        });
      }
    }
  }
}

// Toast 메시지 설정
void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white);
}
