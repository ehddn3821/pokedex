
class SearchResult {
  String name;
  String imgUrl;
  String type;

  SearchResult(this.name, this.imgUrl, this.type);

  // SearchResult.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       imgUrl = json['imgUrl'],
  //       type = json['type'];
  //
  // Map<String, dynamic> toMap() {
  //   final map = Map<String, dynamic>();
  //   map['name'] = name;
  //   map['imgUrl'] = imgUrl;
  //   map['type'] = type;
  //   return map;
  // }
}