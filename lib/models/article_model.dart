class Article{
    String author='';
    String title='';
    String description='';
    String articleUrl='';
    String urlToImage='';
    String content='';
    DateTime  publishedAt;

    Article({required this.title,required this.description,required this.author,required this.content,required this.publishedAt,
    required this.urlToImage, required this.articleUrl});

}