import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_share/flutter_share.dart';

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;
  final String pdfName;
  final String pdfUrl;
  FullPdfViewerScreen(this.pdfPath, this.pdfName, this.pdfUrl);

  Future<void> share() async {
    await FlutterShare.share(
        title: pdfName,
        text: pdfName,
        linkUrl: pdfUrl,
        chooserTitle: pdfName);
  }

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(
          pdfName,
        ),
        centerTitle:true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: share,
          )
        ],
      ),
      path: pdfPath
    );
  }
}