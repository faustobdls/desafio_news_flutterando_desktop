import 'package:dio/dio.dart';
import 'package:desafio_new_flutterando/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewsApi {

  final Dio dio = new Dio();

  Future<List<Articles>> fetchNews() async {
    Response response;
    NewsModel parsedResponse;
    
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      response = await dio.get('https://newsapi.org/v2/everything?q=bitcoin&from=2019-03-21&apiKey=59f195f3284d4a42bf165aae5b61558e');
      parsedResponse = NewsModel.fromJson(response.data);
      await prefs.setString('dnf_articles', jsonEncode(response.data));

    } on DioError catch (e) {
      print(e);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if ( prefs.containsKey('dnf_articles')){
        parsedResponse = NewsModel.fromJson(jsonDecode(prefs.getString('dnf_articles')));
      }else{
        throw Exception("SEM REDE E SEM DADOS EM CACHE");
      }

    } catch (e) {
      print(e);
    }

    return parsedResponse.articles;
  }
}