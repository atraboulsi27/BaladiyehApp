import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  final String pdfName;
  FullPdfViewerScreen(this.pdfPath, this.pdfName);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(
          pdfName,
          style: TextStyle(fontSize: 18),
        ),
        centerTitle:true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                  Icons.share,
              ),
            )
          ),
        ],
      ),
      path: pdfPath
    );
  }
}