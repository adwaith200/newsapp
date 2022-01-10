import '../models/article_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class News{
  List<Article> news  = [];

  Future<void> getNews() async{
     try{
    Response response = await get(Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=8407b56c9b6d40cbb6a7fa1ee376f107"));

    var jsonData =jsonDecode(response.body);
    print(jsonData);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
     }catch(err){
       print("=======================");
       print(err);
     }

}
}

class CategoryNewsClass{
  List<Article> news  = [];

  Future<void> getNews(String category) async{
     try{
       print(category);
    Response response = await get(Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=8407b56c9b6d40cbb6a7fa1ee376f107"));

    var jsonData =jsonDecode(response.body);
    print(jsonData);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          print("yes");
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publishedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
     }catch(err){
       print("=======================");
       print(err);
     }

}
}