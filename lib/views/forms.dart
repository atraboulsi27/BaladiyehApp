import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:baladiyeh/widgets/pdfViewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class Forms  extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}
class _FormsState extends State<Forms> {

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
              return Container(child: LinearProgressIndicator());
            } 
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: (){
                        getFilefromURL(snapshot.data[index].pdf).then((p) 
                        {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => FullPdfViewerScreen(p.path, snapshot.data[index].title, snapshot.data[index].pdf)
                            )
                          );
                        });
                      },
                      title: Text(
                        snapshot.data[index].title,
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                      leading: Icon(Icons.picture_as_pdf),
                    ),
                    elevation: 5.0,
                    color: Colors.grey[50],
                  );
                },
              );
            }
          }
        ),
      ),
    );
  }

  Future<List<ApplicationForm>> _getForms() async {
    var data = await http.get('https://baladiyeh.joomla.com//submissions_forms.txt');
    var jsonData = json.decode(data.body);
    List<ApplicationForm> forms = [];
    for (var u in jsonData) {
      ApplicationForm form = ApplicationForm(u['Name'], u['File']);
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
}
class ApplicationForm{
  String title;
  String pdf;
  ApplicationForm(this.title, this.pdf);
}