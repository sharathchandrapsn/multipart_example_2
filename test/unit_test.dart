import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:multipart_example_2/screens/counter.dart';
import 'package:multipart_example_2/screens/flexible_polyline.dart';

void main() {
  group("counter test", () {
    var counter = Counter();

    // test("test sample", () {
    //   expect(Counter().value, 0);
    // });

    test("increase test", () {
      counter.increment();
      print("value is1:::: ${counter.value}");
      expect(counter.value, 1);
    });

    test("decrease test", () {
      counter.decrement();
      expect(counter.value, 0);
    });
    
    test("decode test", (){

    });
  });
}
