import 'dart:convert';

Poke pokeFromJson(String str) => Poke.fromJson(json.decode(str));

String pokeToJson(Poke data) => json.encode(data.toJson());

class Poke {
  Poke({
    required this.flavorTextEntries,
    required this.genera,
    required this.id,
    required this.names,
  });

  List<FlavorTextEntry> flavorTextEntries;
  List<Genus> genera;
  int id;
  List<Name> names;

  factory Poke.fromJson(Map<String, dynamic> json) => Poke(
    flavorTextEntries: List<FlavorTextEntry>.from(json["flavor_text_entries"].map((x) => FlavorTextEntry.fromJson(x))),
    genera: List<Genus>.from(json["genera"].map((x) => Genus.fromJson(x))),
    id: json["id"],
    names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "flavor_text_entries": List<dynamic>.from(flavorTextEntries.map((x) => x.toJson())),
    "genera": List<dynamic>.from(genera.map((x) => x.toJson())),
    "id": id,
    "names": List<dynamic>.from(names.map((x) => x.toJson())),
  };
}

class FlavorTextEntry {
  FlavorTextEntry({
    required this.flavorText,
    required this.language,
  });

  String flavorText;
  Language language;

  factory FlavorTextEntry.fromJson(Map<String, dynamic> json) => FlavorTextEntry(
    flavorText: json["flavor_text"],
    language: Language.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "flavor_text": flavorText,
    "language": language.toJson(),
  };
}

class Language {
  Language({
    required this.name,
  });

  String name;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Genus {
  Genus({
    required this.genus,
    required this.language,
  });

  String genus;
  Language language;

  factory Genus.fromJson(Map<String, dynamic> json) => Genus(
    genus: json["genus"],
    language: Language.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "genus": genus,
    "language": language.toJson(),
  };
}

class Name {
  Name({
    required this.language,
    required this.name,
  });

  Language language;
  String name;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    language: Language.fromJson(json["language"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "language": language.toJson(),
    "name": name,
  };
}
