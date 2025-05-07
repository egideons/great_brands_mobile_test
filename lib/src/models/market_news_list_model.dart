import 'market_news_model.dart';

class MarketNewsListModel {
  final List<MarketNewsModel> news;

  MarketNewsListModel({required this.news});

  // Factory method to create a list of MarketNewsModel from JSON
  factory MarketNewsListModel.fromJson(List<dynamic>? jsonList) {
    jsonList ??= [];
    List<MarketNewsModel> news = jsonList.map((json) {
      return MarketNewsModel.fromJson(json);
    }).toList();

    return MarketNewsListModel(news: news);
  }
}
