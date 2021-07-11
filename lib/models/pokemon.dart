class Pokemon {
  final String id; // id
  final String name; // 이름
  final String imgUrl; // 이미지
  final String type; // 타입
  final String desc; // 설명
  final String addDesc; // 추가 설명
  final String species; // 분류

  Pokemon(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.type,
      required this.desc,
      required this.addDesc,
      required this.species});

  factory Pokemon.fromJson(Map<String, dynamic> json) => new Pokemon(
        id: json["id"],
        name: json["name"],
        imgUrl: json["img_url"],
        type: json["type"],
        desc: json["desc"],
        addDesc: json["add_desc"],
        species: json["species"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img_url': imgUrl,
        'type': type,
        'desc': desc,
        'add_desc': addDesc,
        'species': species,
      };
}
