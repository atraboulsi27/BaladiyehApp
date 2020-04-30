import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class MunicipalBoard extends StatefulWidget{
  @override
  _MunicipalBoardState createState() => _MunicipalBoardState();
}
class _MunicipalBoardState extends State<MunicipalBoard>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Municipality Board',
        ),
        centerTitle:true,
      ),
      body:  Container(
        child: FutureBuilder(
          future: _getPositions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: LinearProgressIndicator());
            } 
            else {
              return ListView.builder(
                itemCount: snapshot.data[0].length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomSection(
                    data: [snapshot.data[0][index], snapshot.data[1]],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
  Future<List> _getPositions() async {
    var dataPositions = await http.get('https://baladiyeh.joomla.com//board_positions.php');
    var dataMembers = await http.get('https://baladiyeh.joomla.com//board_members.php');
    var jsonDataMembers = json.decode(dataMembers.body);
    var jsonDataPositions = json.decode(dataPositions.body);
    List positions = [];
    for (var jsonEleme in jsonDataPositions) {
      positions.add(jsonEleme['position']);
    }
    List<BoardMember> members = [];
    for (var jsonElem in jsonDataMembers) {
      BoardMember bmember = BoardMember(jsonElem['FirstName'], jsonElem['LastName'], jsonElem['Position'], jsonElem['email'], jsonElem['image'], jsonElem['phone']);
      members.add(bmember);
    }
    return [positions, members];
  }
}

class BoardMember{
  String firstname;
  String lastname;
  String position;
  String email;
  String image;
  String phone;
  BoardMember(this.firstname, this.lastname, this.position, this.email, this.image, this.phone);
}

class CustomSection extends StatelessWidget{
  CustomSection({Key key, this.data}) : super(key: key);

  final List data;
  
  @override
  Widget build(BuildContext context) {
    final String title = data[0];
    List caro  = [];
    for (var i = 0; i < data[1].length; i++) {
      if (data[1][i].position == data[0]){
        caro.add(data[1][i]);
      }
    }
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          CarouselSlider(
            items: caro.map((member) {
              return new Builder(
                builder: (BuildContext context) {
                  return new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: new EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: imgCard(member),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 410,
              autoPlay: false,
              enableInfiniteScroll: false, 
            ),
          ),
        ]
      ),
    );
  }

  Widget imgCard(BoardMember member) {
    const double _cardElevation = 2;
    const double _cardBorderRadius = 10;
    const double _imageHeight = 300;
    const double _smallPadding = 0;
    const double _largePadding = 0;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: _cardElevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(
            "https://baladiyeh.joomla.com/${member.image}",
            fit: BoxFit.cover,
            height: _imageHeight,
          ),
          Container(
            padding: EdgeInsets.only(top:_largePadding, bottom: _smallPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(
                          "${member.firstname} ${member.lastname}",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold),
                        )
                      ),
                    ),
                  ],
                ),
                Text("   Email: ${member.email}", style:TextStyle(fontSize: 16)),
                Text("   Phone: ${member.phone}", style:TextStyle(fontSize: 16)),
              ],
            ),
          )
        ],
      ),
    );
  }
}