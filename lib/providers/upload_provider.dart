import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:multipart_example_2/providers/api_service.dart';

class UploadProvider extends ChangeNotifier{

  Future<String?> uploadImage(filename, url) async {
    print("filename:: $filename \n url:: $url");
    var request = MultipartRequest('POST', Uri.parse(url));
    request.files.add(await MultipartFile.fromPath('picture', filename));
    var res = await request.send();
    if(res.statusCode == 200){
      print("success:: ${res.reasonPhrase}");
    }else{
      print("failed");
    }
    return res.reasonPhrase;
  }

  String? state = "";
  String? url;

  String? get getState => state;

  setState(String? state) {
    this.state = state;
    notifyListeners();
  }

  void setUrl(String url) {
    this.url = url;
    notifyListeners();
  }

  String? get getUrl => url;

}
