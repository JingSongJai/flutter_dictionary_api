class Meanings {
  String? partOfSpeech;
  List<String>? synonyms, antonyms;
  List<Definitions>? definitions;

  Meanings({this.partOfSpeech, this.synonyms, this.antonyms, this.definitions});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    synonyms =
        json['synonyms'] != null ? List<String>.from(json['synonyms']) : [];
    antonyms =
        json['antonyms'] != null ? List<String>.from(json['antonyms']) : [];
    definitions = json['definitions'] != null
        ? (json['definitions'] as List)
            .map((definition) => Definitions.fromJson(definition))
            .toList()
        : [];
  }
}

class Definitions {
  String? definition, example;
  List<String>? synonyms, antonyms;

  Definitions({this.definition, this.synonyms, this.antonyms});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    example = json['example'];
    synonyms =
        json['synonyms'] != null ? List<String>.from(json['synonyms']) : [];
    antonyms =
        json['antonyms'] != null ? List<String>.from(json['antonyms']) : [];
  }
}
