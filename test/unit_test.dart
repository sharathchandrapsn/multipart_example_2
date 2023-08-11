import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:multipart_example_2/providers/upload_provider.dart';
import 'package:provider/provider.dart';

main(){
  group("check image upload status code", () {
    test("upload success or failure", () async{
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {

        // Create sample response of the HTTP call //
        final response = {
          "statusCode": 200,
          "reasonPhrase": "OK"
        };
        return Response(jsonEncode(response), 200);
      });
      // Check whether getNumberTrivia function returns
      // number trivia which will be a String
      // expect(await UploadProvider(mockHTTPClient).uploadImage(), isA<String>());
    });
    //8142100069 371
    });
}

