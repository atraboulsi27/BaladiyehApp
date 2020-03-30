import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baladiyeh/widgets/pdfViewer.dart';
import 'package:path_provider/path_provider.dart';


// Need to work on printing
class Forms  extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
}
class _FormsState extends State<Forms> {
  final _formList = [["Municipal Clearance Request", 'assets/pdforms/sample.pdf'], ["Lease Registration", 'assets/pdforms/sample.pdf'], ["Municipal Fees Installment Request", 'assets/pdforms/sample.pdf'], ["Occupancy License", 'assets/pdforms/sample.pdf'], ["Building Completion", 'assets/pdforms/sample.pdf'], ["Statement of Occupancy", 'assets/pdforms/sample.pdf'], ["Property Transfer declaration", 'assets/pdforms/sample.pdf']];
  Future<String> prepareTestPdf(href) async {
    final ByteData bytes = await DefaultAssetBundle.of(context).load(href);
    final Uint8List list = bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$href';
    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
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
      body: ListView.separated(
        itemCount: _formList.length,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              prepareTestPdf(_formList[index][1]).then((path) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullPdfViewerScreen(path, _formList[index][0])),
                );
              });
            },
            child: Container(
              padding: EdgeInsets.all(18.0),
              child: Text(_formList[index][0]),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey);
        },
      ),
    );
  }
}
