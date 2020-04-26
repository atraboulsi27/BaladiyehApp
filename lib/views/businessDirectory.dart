import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:baladiyeh/classes/professional.dart';
import 'package:baladiyeh/views/professionalProfile.dart';
import 'package:http/http.dart' as http;

class BusinessDirectory extends StatefulWidget {
  @override
  _BusinessDirectoryState createState() => _BusinessDirectoryState();
}
class _BusinessDirectoryState extends State<BusinessDirectory> {
  final TextEditingController _searchControl = new TextEditingController();
  String filter;

  @override
  initState() {
    _searchControl.addListener(() {
      setState(() {
        filter = _searchControl.text;
      });
    });
  }
  @override
  void dispose() {
    _searchControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Business Directory',
        ),
        centerTitle:true,
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: LinearProgressIndicator());
            } 
            else {
              return Material(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          elevation: 6.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: "Search",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                              maxLines: 1,
                              controller: _searchControl,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return filter == null || filter == '' ? professionalCard(snapshot.data[index])
                              : snapshot.data[index].profession.toLowerCase().contains(filter.toLowerCase()) ? professionalCard(snapshot.data[index])
                              : new Container();
                          },
                        ) ,
                      )
                    ],
                  ),
                ),
              );
            }
          },
        )
      ),
    );
  }

  Future<List<Professional>> _getUsers() async {
    var data = await http.get('https://baladiyeh.joomla.com//submissions_businessdirectory.txt');
    var jsonData = json.decode(data.body);
    List<Professional> professionalsList = [];
    for (var professionalJson in jsonData) {
      Professional professional =
          Professional(int.parse(professionalJson['ID']), professionalJson['Address'], "${professionalJson['FirstName']} ${professionalJson['LastName']}", professionalJson['Profession'], professionalJson['Media'],professionalJson['PhoneNumber']);
      professionalsList.add(professional);
    }
    return professionalsList;
  }

  Widget professionalCard(Professional person){
    return Card(
      elevation: 5.0,
      color: Colors.grey[50],
      child: ListTile(
        title: Text(person.name),
        subtitle: Text(person.phone),
        leading: person.picture == null || person.picture == '' ? Image.asset('assets/images/profile.jpg'): Image.network(person.picture),
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(person)));},
      ),
    );
  }
}