import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multipart_example_2/providers/upload_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
 UploadProvider? provider;
@override
  void initState() {
    provider = Provider.of<UploadProvider>(context, listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(provider?.getState.toString() ?? ""),
            ...[

            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ImagePicker imagePicker = ImagePicker();
          var file = await imagePicker.pickImage(source: ImageSource.gallery);
          var res = await provider?.uploadImage(file?.path, widget.url);
          await provider?.setState(res);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}