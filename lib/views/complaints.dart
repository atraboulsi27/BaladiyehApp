import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Complaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}
class _ComplaintsState extends State<Complaints> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();
  String _name;
  String _mobile;
  String _mail;
  String _pass;
  String _subject;

  bool _autoValidate = false;
  var _complaints = [
    'None',
    'Noise',
    'Lost & Found',
    'Vehicles & Parking',
    'Streets & Sidewalks',
    'Public health & Safety',
    'Home & neighbourhood',
    'Other'
  ];
  var _currentItemSelecetd = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaints',
        ),
        centerTitle:true,
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(30.0),
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: form(),
          ),
        ),
      ),
    );
  }

  Widget form() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Full Name'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            _name = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Phone Number'),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (String val) {
            _mobile = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          onSaved: (String val) {
            _mail = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Password'),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onSaved: (String val) {
            _pass = val;
          },
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Complaint Type: ", style: TextStyle(fontSize: 18)),
            new DropdownButton<String>(
              items: _complaints.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );}).toList(),
              onChanged: (String newValueSelected) {
                _onDropDownItemSelected(newValueSelected);
                _subject = newValueSelected;
              },
              value: _currentItemSelecetd,
            ),
          ],
        ),
        new TextField(
          controller: _textFieldController,
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Type in your complaint details', alignLabelWithHint: true),
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: () async {
            _validateInputs();
            await sendMail(_mail, _pass, _subject, _textFieldController.text, _name, _mobile);
          },
          child: new Text('Send Complaint'),
        ),
      ],
    );
  }
  

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {this._currentItemSelecetd = newValueSelected;});
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() 
        { 
          _autoValidate = true;
        }
      );
    }
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }
  
  String validateMobile(String value) {
    if (value.length != 8)
      return 'Mobile Number must be of 8 digits';
    else
      return null;
  }

  Future sendMail(mail, password, subject, content, name, phone) async {

    final smtpServer = gmail(mail, password); 

    final message = Message()
      ..from = Address(mail)
      ..recipients.add('charbel.g.frangieh@gmail.com')
      ..subject = subject
      ..text = '$content \n\n\nBest Regards \n$name \n$phone \n${DateTime.now()}';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());//print if the email is sent
      return AlertDialog(
        content: Text("Message Successful"),
      );
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
      return AlertDialog(
        content: Text("Message Unsuccessful"),
      );
    }
  } 

}