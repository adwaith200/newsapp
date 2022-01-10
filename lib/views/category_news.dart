import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/views/home.dart';
import '../models/article_model.dart';

class CategoryNews extends StatefulWidget {
  String category;
  CategoryNews({required this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<Article> articles = [];
  bool _loading = true;

  void initState() {
    super.initState();
    getCategoryNews();
  }

  void getCategoryNews() async {
    CategoryNewsClass news = CategoryNewsClass();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          title: Row(
            children: [
              Text("Flutter"),
              Text("News", style: TextStyle(color: Colors.greenAccent))
            ],
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(15),
                        child: ListView.builder(
                            itemCount: articles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  imageUrl: articles[index].urlToImage,
                                  title: articles[index].title,
                                  desc: articles[index].description,
                                  articleUrl: articles[index].articleUrl);
                            }))
                  ],
                )),
              ));
  }
}
