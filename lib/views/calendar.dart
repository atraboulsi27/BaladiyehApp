import 'dart:convert';
import 'dart:core';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}
class _CalendarState extends State<Calendar> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar of Events',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getDataSource(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: LinearProgressIndicator());
          } 
          else {
            print(snapshot.data[1].from);
            return  SfCalendar(
              view: CalendarView.month,
              dataSource: MeetingDataSource(snapshot.data),
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true,
              ),
              todayHighlightColor: Colors.green,
            );
          }
        }
      )
    );
  }
  Future <List<Meeting>> _getDataSource() async{
    var data = await http.get('https://baladiyeh.joomla.com//calendar.php');
    var jsonData = json.decode(data.body);
    List<Meeting> meetings = [];
    
    for (var elem in jsonData) {
      DateTime start = DateTime.fromMillisecondsSinceEpoch(int.parse(elem['start'])*1000);
      DateTime end = DateTime.fromMillisecondsSinceEpoch(int.parse(elem['end'])*1000);
      Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      Meeting meeting = Meeting(elem['Name'], start, end, color, true);
      meetings.add(meeting);
    }
    return meetings;
  }
}
class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}