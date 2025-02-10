class Phenotics {
  String? text, audio, sourceUrl;
  License? license;

  Phenotics({this.text, this.audio, this.sourceUrl, this.license});

  Phenotics.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    audio = json['audio'];
    sourceUrl = json['sourceUrl'];
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
  }
}

class License {
  String? name, url;

  License({this.name, this.url});

  License.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
