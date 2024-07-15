class Leagues {
  final String? id;
  final String? uid;
  final String? name;
  final String? abbreviation;
  final String? slug;
  final Season? season;
  final String? calendarType;
  final bool? calendarIsWhitelist;
  final String? calendarStartDate;
  final String? calendarEndDate;
  final List<Logo>? logos;


  Leagues({
    this.id,
    this.uid,
    this.name,
    this.abbreviation,
    this.slug,
    this.season,
    this.calendarType,
    this.calendarIsWhitelist,
    this.calendarStartDate,
    this.calendarEndDate,
    this.logos,
  });

  factory Leagues.fromJson(Map<String, dynamic> json) {
    return Leagues(
      id: json['id'],
      uid: json['uid'],
      name: json['name'],
      abbreviation: json['abbreviation'],
      slug: json['slug'],
      season: json['season'] != null ? Season.fromJson(json['season']) : null,
      calendarType: json['calendarType'],
      calendarIsWhitelist: json['calendarIsWhitelist'],
      calendarStartDate: json['calendarStartDate'],
      calendarEndDate: json['calendarEndDate'],
      logos: (json['logos'] as List<dynamic>?)
          ?.map((logoJson) => Logo.fromJson(logoJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'abbreviation': abbreviation,
      'slug': slug,
      'season': season?.toJson(),
      'calendarType': calendarType,
      'calendarIsWhitelist': calendarIsWhitelist,
      'calendarStartDate': calendarStartDate,
      'calendarEndDate': calendarEndDate,
      'logos': logos?.map((logo) => logo.toJson()).toList(),

    };
  }
}

class Season {
  final int? year;
  final Map<String, dynamic>? type;

  Season({this.year, this.type});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      year: json['year'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'type': type,
    };
  }
}


class Logo {
  final String? href;
  final int? width;
  final int? height;
  final String? alt;
  final List<String>? rel;
  final String? lastUpdated;

  Logo({
    this.href,
    this.width,
    this.height,
    this.alt,
    this.rel,
    this.lastUpdated,
  });

  factory Logo.fromJson(Map<String, dynamic> json) {
    return Logo(
      href: json['href'],
      width: json['width'],
      height: json['height'],
      alt: json['alt'],
      rel: (json['rel'] as List<dynamic>?)?.map((e) => e as String).toList(),
      lastUpdated: json['lastUpdated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'href': href,
      'width': width,
      'height': height,
      'alt': alt,
      'rel': rel,
      'lastUpdated': lastUpdated,
    };
  }
}
