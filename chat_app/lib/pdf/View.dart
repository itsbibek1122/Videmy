import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class View extends StatefulWidget {
  final file;

  View({this.file});

  @override
  State<View> createState() => _ViewState(file);
}

class _ViewState extends State<View> {
  _ViewState(this.file);
  final file;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF", textAlign: TextAlign.center),
      ),
      body: Stack(
        children: [
          Positioned(
            child: SfPdfViewer.network(
              file,
              pageLayoutMode: PdfPageLayoutMode.single,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.transparent,
              ),
              // child:AudioFile(advancedPlayer: advancedPlayer)
            ),
          )
        ],
      ),
    );
  }
}
