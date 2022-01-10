import 'package:flutter/material.dart';
import 'package:news_app/helper/auth.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool _loading = true;

  List<CategoryModel> categories = [];
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        title: Row(
          children: [
            Text("Flutter"),
            Text("News", style: TextStyle(color: Colors.greenAccent)),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 20,
            width: 20,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLniMmaEqbBPBR7G59oZncZ3dDI9wS8Vau6A&usqp=CAU"),
            ),
          ),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    //categories
                    Container(
                        height: 70,
                        child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                  imageUrl: categories[index].imageUrl,
                                  categoryName: categories[index].categoryName);
                            })),

                    //Blogs
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
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String imageUrl;
  String categoryName;

  CategoryTile({required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryNews(category: categoryName.toLowerCase())));
      },
      child: Container(
          margin: EdgeInsets.all(8),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl,
                      width: 120, height: 60, fit: BoxFit.cover)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(categoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)))
            ],
          )),
    );
  }
}

class BlogTile extends StatelessWidget {
  String title = '', imageUrl = '', desc = '', articleUrl = '';
  BlogTile(
      {required this.imageUrl,
      required this.title,
      required this.desc,
      required this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(imageUrl: articleUrl)));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              ClipRRect(
                child: Image.network(imageUrl),
                borderRadius: BorderRadius.circular(7),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Text(desc,
                  style: TextStyle(
                    color: Colors.grey[700],
                    // fontSize: 20,
                    // fontWeight: FontWeight.bold
                  )),
              Divider(height: 30, color: Colors.blueGrey[400])
            ],
          )),
    );
  }
}
