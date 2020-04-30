import 'package:flutter/material.dart';
import 'package:baladiyeh/classes/article.dart';
import 'package:flutter_html/flutter_html.dart';

class ArticleDetail extends StatelessWidget{
  final Article article;
  ArticleDetail(this.article);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("${article.category}"),
      ),
      body: new Center(
        child: SingleChildScrollView(
          child: Html(
            data: "${article.headline} ${article.content}",
            padding: EdgeInsets.all(8.0),
            linkStyle: const TextStyle(
              color: Colors.blue,
              decorationColor: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            onLinkTap: (url) {
              print("Opening $url...");
            },
            onImageTap: (src) {
              print(src);
            },
          ),
        ),
      ),
    );
  }
}