import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:web_scraper/web_scraper.dart';

import 'detail_page.dart';

class SearchResultPage extends StatefulWidget {
  var searchResults = <SearchResult>[];

  SearchResultPage({required this.searchResults});

  @override
  _SearchResultPageState createState() => _SearchResultPageState(searchResults);
}

class _SearchResultPageState extends State<SearchResultPage> {
  var searchResults = <SearchResult>[];
  var searchResult = <SearchResult>[];

  _SearchResultPageState(this.searchResults);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = size.height / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(title: Text('검색 결과')),
        body: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            children: List.generate(searchResults.length, (index) {
              return Container(
                  padding: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () async {
                      await initPokeScrap(searchResults[index].id!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(searchResult: searchResult)));
                    },
                    child: Column(
                      children: <Widget>[
                        Image.network(searchResults[index].imgUrl), // 이미지
                        Text(
                          // 이름
                          '${searchResults[index].name}',
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text('${searchResults[index].addDesc}') // 부가 설명
                      ],
                    ),
                  ));
            })));
  }

  // Web Scraper
  Future<bool> initPokeScrap(String searchText) async {
    final webScraper = WebScraper('https://www.pokemonkorea.co.kr');

    // 포켓몬 인덱스 추출
    int fIdx = searchText.indexOf("'");
    int sIdx = searchText.lastIndexOf("'");
    String searchIdx = searchText.substring(fIdx + 1, sIdx).trim();
    final endpoint = '/pokedex/view/$searchIdx';

    if (await webScraper.loadWebPage(endpoint)) {
      // 이전 검색값 초기화
      searchResult = <SearchResult>[];

      // 포켓몬 이름
      final nameElements = webScraper.getElement(
          '#top > div.book-ct > div > div > div:last-child > h3', []);
      final searchNames = <String>[];
      nameElements.forEach((element) {
        final name = element['title'];
        searchNames.add(name);
      });

      // 포켓몬 사진
      final imgUrlElements = webScraper.getElementAttribute(
          '#top > div.book-ct > div > div > div:nth-child(1) > img', 'src');
      final searchImgUrls = <String>[];
      imgUrlElements.forEach((element) {
        final imgUrl = element;
        searchImgUrls.add(imgUrl!);
      });

      // 포켓몬 타입
      final typeElements1 = webScraper.getElement(
          '#top > div.book-ct > div > div > div:last-child > div.bx-detail > div:nth-child(1) > div:nth-child(1) > div > span:nth-child(1) > p',
          []);
      final typeElements2 = webScraper.getElement(
          '#top > div.book-ct > div > div > div:last-child > div.bx-detail > div:nth-child(1) > div:nth-child(1) > div > span:last-child > p',
          []);
      final searchTypes = <String>[];
      String searchType;
      typeElements1.forEach((element) {
        final type = element['title'];
        searchTypes.add(type);
      });
      typeElements2.forEach((element) {
        final type = element['title'];
        searchTypes.add(type);
      });
      if (searchTypes[0] != searchTypes[1]) {
        searchType = '${searchTypes[0]}, ${searchTypes[1]} 타입';
      } else {
        searchType = '${searchTypes[0]} 타입';
      }

      // 포켓몬 설명
      final descElements = webScraper.getElement(
          '#top > div.book-ct > div > div > div:last-child > p', []);
      final searchDesc = <String>[];
      descElements.forEach((element) {
        final desc = element['title'];
        searchDesc.add(desc);
      });

      // 포켓몬 추가 설명
      final addDescElements = webScraper.getElement(
          '#top > div.book-ct > div > div > div:last-child > h3 > p:last-child',
          []);
      final searchAddDesc = <String>[];
      addDescElements.forEach((element) {
        final addDesc = element['title'];
        searchAddDesc.add(addDesc);
      });

      // 포켓몬 분류
      final groupElements = webScraper.getElement(
          '#top > div.book-ct > div > div > div:last-child > div.bx-detail > div:nth-child(1) > div:last-child > p',
          []);
      final searchGroup = <String>[];
      groupElements.forEach((element) {
        final addGroup = element['title'];
        searchGroup.add(addGroup);
      });

      searchResult.add(SearchResult('', searchNames[0], searchImgUrls[0],
          searchType, searchDesc[0], searchAddDesc[0], searchGroup[0]));

      if (mounted) {
        setState(() {
          this.searchResult = searchResult;
        });
      }
    }
    return true;
  }
}
