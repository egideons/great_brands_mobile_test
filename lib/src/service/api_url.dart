class ApiUrl {
  static const baseUrl = "https://finnhub.io/api/v1";
  static const marketNewsEndpoint = "/news";
  static category(value) => "/?category=$value";
  static token(value) => "&token=$value";
}
