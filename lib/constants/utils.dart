import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result!.files.isNotEmpty) {
      for (int i = 0; i < result.files.length; i++) {
        images.add(File(
          result.files[i].path!,
        ));
      }
    }
  } catch (e) {
    // print(e.toString());
  }
  return images;
}
