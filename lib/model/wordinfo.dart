import 'package:project_dictionary/model/meanings.dart';
import 'package:project_dictionary/model/phenotics.dart';

class WordInfo {
  String? word, phonetic;
  List<Phenotics>? phonetics;
  List<Meanings>? meanings;

  WordInfo({this.word, this.phonetic, this.phonetics, this.meanings});

  WordInfo.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    phonetic = json['phonetic'];
    phonetics = json['phonetics'] != null
        ? (json['phonetics'] as List)
            .map((phonetic) => Phenotics.fromJson(phonetic))
            .toList()
        : [];
    meanings = json['meanings'] != null
        ? (json['meanings'] as List)
            .map((meaning) => Meanings.fromJson(meaning))
            .toList()
        : [];
  }
}
