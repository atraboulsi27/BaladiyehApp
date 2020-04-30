import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:baladiyeh/classes/article.dart';


class TownPage extends StatefulWidget{
  @override
  _TownPageState createState() => _TownPageState();
}

class _TownPageState extends State<TownPage> {

  Future<List> _getTownInfo() async{
    var data = await http.get('https://baladiyeh.joomla.com//town.php');
    var jsonData = json.decode(data.body);
    List<Article> articles = [];
    for (var ar in jsonData) {
      Article article = Article(ar['id'], ar['title'], ar['headline'], ar['content'], 'Town');
      articles.add(article);
    }
    return articles;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Town General Info"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getTownInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: LinearProgressIndicator());
            } 
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Html(
                    data: "${snapshot.data[index].headline} ${snapshot.data[index].content}  <hr>",
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
                  );
                }
              );
            }
          }
        ),
      ),
    );
  }
}