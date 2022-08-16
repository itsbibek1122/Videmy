import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PDF extends StatefulWidget {
  final void Function(File pickedpdf) getpdfvalue;
  PDF(this.getpdfvalue);

  @override
  State<PDF> createState() => _PDFState();
}

class _PDFState extends State<PDF> {
  File? file;

  uploadDataToFirebase(FilePicker pdfType) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));

    widget.getpdfvalue(file!);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : "No File Selected";
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () => uploadDataToFirebase(FilePicker.platform),
          icon: const Icon(Icons.link_outlined),
          label: const Text('Add PDF'),
        ),
        SizedBox(
            width: 100,
            height: 100,
            child: SizedBox(
                child: Text(
              fileName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ))),
      ],
    );
  }
}
