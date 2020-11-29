class ApiSetting{
  String host;
  String postfix;
  String get _host => host;
  String get _postfix => postfix;
  ApiSetting.initial()
  :
  host = "http://harkomar.com",
  postfix = "/amr-api";
}