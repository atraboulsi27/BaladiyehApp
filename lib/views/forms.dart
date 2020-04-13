import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baladiyeh/widgets/pdfViewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


// Need to work on printing
class Forms  extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}
class _FormsState extends State<Forms> {
  Future<List<AppForm>> _getForms() async {
    var data = await http.get('https://baladiyeh.joomla.com//submissions_forms.txt');
    var jsonData = json.decode(data.body);
    List<AppForm> forms = [];
    for (var u in jsonData) {
      AppForm form =
          AppForm(u['Name'], u['File']);
      forms.add(form);
    }
    return forms;
  }
  Future <File> getFilefromURL(String url) async {
    try{
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/form.pdf');
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;

    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Application Forms',
        ),
        centerTitle:true,
      ),
      body: Container(
        child: FutureBuilder(
          future: _getForms(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text('Loading News . . . ')));
            } 
            else {
              return ListView.separated(
                itemCount: snapshot.data.length,
                padding: const EdgeInsets.all(20.0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      getFilefromURL(snapshot.data[index].pdf).then((p) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPdfViewerScreen(p.path, snapshot.data[index].title)),
                        );
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(18.0),
                      child: Text(snapshot.data[index].title),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey);
                },
              );
            }
          }
        ),
      ),
    );
  }
}
class AppForm{
  String title;
  String pdf;
  AppForm(this.title, this.pdf);
}