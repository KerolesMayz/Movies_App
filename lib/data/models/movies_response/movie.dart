class Movie {
  Movie({
    this.id,
    this.title,
    this.year,
    this.rating,
    this.mediumCoverImage,
    this.largeCoverImage,
  });

  Movie.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    rating = json['rating'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
  }

  num? id;
  String? title;
  num? year;
  num? rating;
  String? mediumCoverImage;
  String? largeCoverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['year'] = year;
    map['rating'] = rating;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    return map;
  }
}
