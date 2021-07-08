import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/search_result_page.dart';
import 'package:pokedex/pages/web_page.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 상하 중앙정렬
            crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우 화면크기랑 같게
            children: [
              Image(image: AssetImage('images/logo.png'), height: 180),
              MaterialButton(
                  child: Text('🔥  포켓몬 공식 사이트 가기  🔥',
                      style: TextStyle(fontSize: 18.0)),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.redAccent, width: 2)
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WebPage()));
                  }),
              SizedBox(height: 20),
              TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '포켓몬 이름이나 번호, 타입 등을 입력해보세요.',
                  ),
                  onSubmitted: (value) async {
                    if (myController.text.isNotEmpty) {
                      CircularProgressIndicator();
                      await initPokeScrap();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResultPage(
                                  searchResults: searchResults)));
                    } else {
                      showToast('검색어를 입력해주세요.');
                    }
                  }),
              SizedBox(height: 10),
              FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () async {
                  if (myController.text.isNotEmpty) {
                    CircularProgressIndicator();
                    await initPokeScrap();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchResultPage(
                                searchResults: searchResults)));
                  } else {
                    showToast('검색어를 입력해주세요.');
                  }
                },
              )
            ],
          ),
        ));
  }

  // Web Scraper
  Future<bool> initPokeScrap() async {
    final webScraper = WebScraper('https://www.pokemonkorea.co.kr');
    final searchText = myController.text;
    final endpoint = '/pokedex?word=$searchText';

    if (await webScraper.loadWebPage(endpoint)) {
      // 이전 검색값 초기화
      searchResults = <SearchResult>[];

      // 포켓몬 id
      final idElements =
          webScraper.getElementAttribute('#pokedexlist > li > a', 'href');
      final searchId = <String>[];
      idElements.forEach((element) {
        final id = element;
        searchId.add(id!);
      });

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

      // 포켓몬 추가 설명
      final addDescElements =
          webScraper.getElement('#pokedexlist > li > a > div.bx-txt > p', []);
      final searchAddDesc = <String>[];
      addDescElements.forEach((element) {
        final addDesc = element['title'];
        searchAddDesc.add(addDesc);
      });

      for (int i = 0; i < searchNames.length; i++) {
        searchResults.add(SearchResult(searchId[i], searchNames[i],
            searchImgUrls[i], '', '', searchAddDesc[i], ''));
      }

      if (mounted) {
        setState(() {
          this.searchResults = searchResults;
        });
      }
    }
    return true;
  }
}

// Toast 메시지
void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.grey,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white);
}
