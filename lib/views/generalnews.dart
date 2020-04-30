import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'articleNews.dart';
import 'package:flutter_html/flutter_html.dart';


class News extends StatefulWidget {
  final String category;
  News(this.category);
  @override
  _NewsState createState() => _NewsState();
}
class _NewsState extends State<News> {
  Future<List<Article>> _getNews() async {
    var data = await http.get('http://baladiyeh.joomla.com//news.php');
    var jsonData = json.decode(data.body);
    List<Article> articles = [];
    for (var u in jsonData) {
      Article article =
          Article(u['id'], u['Title'], u['Headline'], u['Content'], u['Category']);
      articles.add(article);
    }
    return articles;
  }
  Future<List> _getCategories() async {
    var data = await http.get('http://baladiyeh.joomla.com//categories.php');
    var jsonData = json.decode(data.body);
    List categories = [];
    for (var u in jsonData) {
      categories.add(u['Category']);
    }
    return categories;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category}',
        ),
        centerTitle:true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color:Colors.white ,), 
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));},
        ),
      ),
      endDrawer: Drawer(
        child: FutureBuilder(
          future: _getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: LinearProgressIndicator());
            } 
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index]),
                    trailing: Icon(Icons.library_books),
                    onTap: () {String category = snapshot.data[index];Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
                  );
                },
              );
            }
          },
        ),
        // child: ListView(
        //   children: <Widget>[
        //     DrawerHeader(
        //         padding: const EdgeInsets.all(0.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: Colors.blueAccent,
        //           ),
        //         )),
            // ListTile(
            //   title: Text("General"),
            //   trailing: Icon(Icons.library_books),
            //   onTap: () {String category = "General";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
            // ),
        //     ListTile(
        //       title: Text("Sports"),
        //       trailing: Icon(Icons.directions_run),
        //       onTap: () {String category = "Sport";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
        //     ),
        //     ListTile(
        //       title: Text("Food"),
        //       trailing: Icon(Icons.fastfood),
        //       onTap: () {String category = "Food";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
        //     ),
        //     ListTile(
        //       title: Text("Marriage"),
        //       trailing: Icon(Icons.people),
        //       onTap: () {String category = "Marriage";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
        //     ),
        //     ListTile(
        //       title: Text("Environment"),
        //       trailing: Icon(Icons.public),
        //       onTap: () {String category = "Environment";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
        //     ),
        //     ListTile(
        //       title: Text("Technology"),
        //       trailing: Icon(Icons.laptop),
        //       onTap: () {String category = "Technology";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
        //     ),
        //     ListTile(
        //       title: Text("Emergency"),
        //       trailing: Icon(Icons.warning),
        //       onTap: () {String category = "Emergency";Navigator.push(context, MaterialPageRoute(builder: (context) => News(category)));},
        //     ),
        //   ],
        // ),
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
        subtitle: Html(data: article.headline),
        isThreeLine: true,
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetail(article)));},
      ),
    );
  }
}
class Article {
  final String id;
  final String title;
  final String headline;
  final String content;
  final String category;
  Article(this.id, this.title, this.headline, this.content, this.category);
}

