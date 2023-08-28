import 'package:flutter/material.dart';
import 'package:multipart_example_2/providers/upload_provider.dart';
import 'package:multipart_example_2/screens/flexible_polyline.dart';
import 'package:multipart_example_2/screens/latlngz.dart';
import 'package:multipart_example_2/screens/upload_page.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UploadProvider>(context, listen: false);
    TextEditingController controller = TextEditingController();
    provider.setUrl("https://fakestoreapi.com/products");
    controller.text = provider.getUrl!;
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter File Upload Example')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Text(
                "Insert the URL that will receive the Multipart POST request (including the starting http://)",
              ),
              TextField(
                controller: controller,
                onSubmitted: (str) => switchScreen(controller.text, context),
              ),
              TextButton(
                child: const Text("Take me to the upload screen"),
                onPressed: (){
                  List<LatLngZ> latLngList = FlexiblePolyline.decode(FlexiblePolyline.encodeString);
                  print("latLngList is:: $latLngList");
                  switchScreen(controller.text, context);
                },
              )
            ],
          ),
        ));
  }

  void switchScreen(url, context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => UploadPage(url: url)));
}
