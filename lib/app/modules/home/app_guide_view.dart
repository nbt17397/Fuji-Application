import 'package:flutter/material.dart';import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AppGuideScreen extends StatefulWidget {
  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Guide'),
      ),
      body:  SfPdfViewer.network(
        'https://iot.montanarigiulio.com/file_macchine/guide/guide-en.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
