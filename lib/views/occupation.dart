import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:baladiyeh/classes/professional.dart';
import 'package:baladiyeh/views/professionalProfile.dart';
import 'package:http/http.dart' as http;

// Need to create a first layer page displaying all the jobs and for each job we'll display this directory page
class BusinessDirectory extends StatefulWidget {
  @override
  _BusinessDirectoryState createState() => _BusinessDirectoryState();
}
class _BusinessDirectoryState extends State<BusinessDirectory> {
  Future<List<Professional>> _getUsers() async {
    var data = await http.get('http://www.json-generator.com/api/json/get/cfBZjrRMMO?indent=2');
    var jsonData = json.decode(data.body);
    List<Professional> professionalsList = [];
    for (var professionalJson in jsonData) {
      Professional professional =
          Professional(professionalJson['index'], professionalJson['address'], professionalJson['name'], professionalJson['email'], professionalJson['picture'],professionalJson['phone']);
      professionalsList.add(professional);
    }
    return professionalsList;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Business Directory',
          style:TextStyle(
            fontSize:24.0,
            color:Colors.white,
          ),
        ),
        centerTitle:true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text('Loading . . . ')));
            } 
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data[index].picture
                      ),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index])));
                    },
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