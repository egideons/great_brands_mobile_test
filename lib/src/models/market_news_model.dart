class MarketNewsModel {
  final String category;
  final int datetime;
  final String headline;
  final int id;
  final String image;
  final String related;
  final String source;
  final String summary;
  final String url;

  MarketNewsModel({
    required this.category,
    required this.datetime,
    required this.headline,
    required this.id,
    required this.image,
    required this.related,
    required this.source,
    required this.summary,
    required this.url,
  });

  // Factory method to create an instance from JSON
  factory MarketNewsModel.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return MarketNewsModel(
      category: json['category'] ?? "",
      datetime: json['datetime'] ?? 0,
      headline: json['headline'] ?? "",
      id: json['id'] ?? 0,
      image: json['image'] ?? "",
      related: json['related'] ?? "",
      source: json['source'] ?? "",
      summary: json['summary'] ?? "",
      url: json['url'] ?? "",
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'datetime': datetime,
      'headline': headline,
      'id': id,
      'image': image,
      'related': related,
      'source': source,
      'summary': summary,
      'url': url,
    };
  }
}
