import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'articleNews.dart';

class News extends StatefulWidget {
  final String category;
  News(this.category);
  @override
  _NewsState createState() => _NewsState();
}
class _NewsState extends State<News> {
  Future<List<Article>> _getNews() async {
    var data = await http.get('https://baladiyeh.joomla.com//submissions_news.txt');
    var jsonData = json.decode(data.body);
    List<Article> articles = [];
    for (var u in jsonData) {
      if ((u['Media'] is String) == false) {
        u['Media'] = 'https://i.picsum.photos/id/685/300/200.jpg';
      }
      Article article =
          Article(u['Source'], u['Headline'], u['Details'], u['https://www.dead.com'], u['Media'],u['Date'],u['Channel']);
      articles.add(article);
    }
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category} News',
        ),
        centerTitle:true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Colors.white ,), 
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));},
        ),
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
              onTap: () {String category = "General";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
            ListTile(
              title: Text("Sports"),
              trailing: Icon(Icons.directions_run),
              onTap: () {String category = "Sport";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
            ListTile(
              title: Text("Food"),
              trailing: Icon(Icons.fastfood),
              onTap: () {String category = "Food";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
            ListTile(
              title: Text("Marriage"),
              trailing: Icon(Icons.people),
              onTap: () {String category = "Marriage";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
            ListTile(
              title: Text("Environment"),
              trailing: Icon(Icons.public),
              onTap: () {String category = "Environment";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
            ListTile(
              title: Text("Technology"),
              trailing: Icon(Icons.laptop),
              onTap: () {String category = "Technology";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
            ListTile(
              title: Text("Emergency"),
              trailing: Icon(Icons.warning),
              onTap: () {String category = "Emergency";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            ),
          ],
        ),
      ),
      body:
        Container(
          child: FutureBuilder(
            future: _getNews(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: LinearProgressIndicator());
              } 
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data[index].category == widget.category) {
                      return newsCard(snapshot.data[index]);
                    }
                    else if (widget.category == "General"){
                      return newsCard(snapshot.data[index]);
                    }
                    else{
                      return Container();
                    }
                  },
                );
              }
            },
          )
        ),         
    );
  }
  Widget newsCard(Article article){
    return Card(
      elevation: 5.0,
      color: Colors.grey[50],
      child: ListTile(
        title: Text(article.title),
        subtitle: Text(article.description),
        leading: Image.network(article.image),
        isThreeLine: true,
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetail(article)));},
        // trailing: Text(article.date),
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
  final String category;
  Article(this.source, this.title, this.description, this.url, this.image, this.date, this.category);
}

