class SearchResult {
  String? id;       // id
  String name;      // 이름
  String imgUrl;    // 이미지
  String type;      // 타입
  String? desc;     // 설명
  String? addDesc;  // 추가 설명
  String? group;    // 분류

  SearchResult(this.id, this.name, this.imgUrl, this.type, this.desc, this.addDesc, this.group);
}
