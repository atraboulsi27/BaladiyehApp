import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Need to work on specific news pages, maybe do a general page and pass parameters with news (i.e: News(tech) will display the tech news page)
class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}
class _NewsState extends State<News> {
  Future<List<Article>> _getNews() async {
    var data = await http.get('http://newsapi.org/v2/everything?q=corona&from=2020-03-24&sortBy=publishedAt&apiKey=7416c19f810740c0ae185eb497a7a4cc');
    var jsonData = json.decode(data.body);
    List<Article> articles = [];
    for (var u in jsonData['articles']) {
      Article article =
          Article(u['source']['name'], u['title'], u['description'], u['url'], u['urlToImage'],u['publishedAt'],u['content']);
      articles.add(article);
    }
    return articles;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'General News',
          style:TextStyle(
            fontSize:24.0,
            color:Colors.white,
          ),
        ),
        centerTitle:true,
        backgroundColor: Colors.blueAccent,
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                )),
            ListTile(
              title: Text("General"),
              trailing: Icon(Icons.library_books),
              onTap: () {},
            ),
            ListTile(
              title: Text("Sports"),
              trailing: Icon(Icons.directions_run),
              onTap: () {},
            ),
            ListTile(
              title: Text("Food"),
              trailing: Icon(Icons.fastfood),
              onTap: () {},
            ),
            ListTile(
              title: Text("Marriage"),
              trailing: Icon(Icons.people),
              onTap: () {},
            ),
            ListTile(
              title: Text("Environment"),
              trailing: Icon(Icons.public),
              onTap: () => {},
            ),
            ListTile(
              title: Text("Technology"),
              trailing: Icon(Icons.laptop),
              onTap: () => {},
            ),
            ListTile(
              title: Text("Emergency"),
              trailing: Icon(Icons.warning),
              onTap: () => {},
            ),
            ListTile(
              title: Text("Customise"),
              trailing: Icon(Icons.playlist_add),
              onTap: () => {},
            )
          ],
        ),
      ),
      body:
        Container(
          child: FutureBuilder(
            future: _getNews(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text('Loading News . . . ')));
              } 
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomListItemTwo(
                      thumbnail: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data[index].image)
                          )
                        ),
                      ),
                      title: snapshot.data[index].title,
                      description: snapshot.data[index].description,
                      source: snapshot.data[index].source,
                      publishDate: snapshot.data[index].date,
                    );
                  },
                );
              }
            },
          )
        ),         
    );
  }
}
class Article {
  final String source;
  final String title;
  final String description;
  final String url;
  final String image;
  final String date;
  final String content;
  Article(this.source, this.title, this.description, this.url, this.image, this.date, this.content);
}
class ArticleDetail extends StatelessWidget{
  final Article article;
  ArticleDetail(this.article);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              article.title,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              article.description,
            ),
            Text(
              article.content,
            ),
            Text(
              article.date,
            ),
            Text(
              article.source,
            ),
          ],
        ),
      ),
    );
  }
}
class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.description,
    this.source,
    this.publishDate,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String description;
  final String source;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  description: description,
                  source: source,
                  publishDate: publishDate,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.description,
    this.source,
    this.publishDate,
  }) : super(key: key);

  final String title;
  final String description;
  final String source;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$source',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
