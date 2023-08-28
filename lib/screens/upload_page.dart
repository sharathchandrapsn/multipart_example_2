import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multipart_example_2/providers/upload_provider.dart';
import 'package:multipart_example_2/screens/latlngz.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:georange/georange.dart';


class UploadPage extends StatefulWidget {
  // const UploadPage({Key? key, required this.latLngList}) : super(key: key);
  // final List<LatLngZ> latLngList;
  const UploadPage({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
 UploadProvider? provider;
 //====================================================
 // created controller to display Google Maps
 Completer<GoogleMapController> _controller = Completer();
 //on below line we have set the camera position
 static final CameraPosition _kGoogle = const CameraPosition(
   target: LatLng(32.94011, -96.75379),
   zoom: 12,
 );

 final Set<Marker> _markers = {};
 final Set<Polyline> _polyline = {};

 // list of locations to display polylines
 List<LatLng> latLng = [];
 // List<LatLng> latLen = [
 //   LatLng(19.0759837, 72.8776559),
 //   LatLng(28.679079, 77.069710),
 //   LatLng(26.850000, 80.949997),
 //   LatLng(24.879999, 74.629997),
 //   LatLng(16.166700, 74.833298),
 //   LatLng(12.971599, 77.594563),
 // ];
 //=========================================================================
@override
  void initState() {
    provider = Provider.of<UploadProvider>(context, listen: false);

    // PolylinePoints polylinePoints = PolylinePoints();

    // List<PointLatLng> result = polylinePoints.decodePolyline("BGq335-Bj0ot4FJgCTwMAoVAwqBU8GkDsOgFsYoB0KUgPTk1BAsJkhBTwRA8GAwgBA0PAkXT0PA0ZAsEAgK8B0F8BwHwCwM4D4IkDA7LAzeA7GAjIAvWUjSAnGA7aUnVAnLArOAjDUrYAvRAzKUnQAnVAvHU3cAnVA3XoBnnCArTArJA_dAnBUjSA7BAjIAvgBA_JUjXA36BUzjBAzFAvHUj_BUrdUnfA_YAnaAjIUnVArYA7kBU_nBAnVAzKUjSA3IArYArJT7aAzFTzKAjSTzPTvbTvbTvbTjcAjXTrTArJUrYA3NUjSUrJwCrTkDjSoLzjBoG7Q8G7QkInQ4I7QkNrY8B3DgUjmB4I7QoBvCkDzFgoBzrC46BnvDoGnL4I7QsEjI4DnGwM3XsY7uB0ZvvB8LvWsxB39C8LvWkhB79BwHrOsJjSkIrOsE_JoG_OsEvMkDzKwC3IoBrE4DjSwC3SU_TAjIA7LAnQA_EAnVAzUAnVAnVA7VA3DAvRA3NA3STnVT7VAvgBAzKA3NUzjBU7lDAnfAvHArnBU_TwC_TkD_TsErTwCvHkDnL8G7VwCjIwCrJkD3NoBzFkDrT8BvRAzPA_EA_YU7aA_TTvlBUjIoB7awCnQkD7Q8B3IkD7L8GvW0FvR0F7QoB3DoL3hBsEjN8GnVoGnVwCnL8B7GkDjNoBrJ8B7LoBrOA3IAzPA7QAvHAzFA7GU3hB3D_qCnBrlCUjgEAjNA7QAvlBAzKArEArJU7kBAzUAjNA3cArsBU7nCUv0BAzeAnGA_EA3mBA7fT7uBAnQAjNA3DAvMAzUA3DAnQAzKA3IAzZA3NAjNAvCAnfAvWTvqBAjSAzFA7QA7GAjmBAvMAvCAzZAnVUjSA7GAjXArJTjN7B3XnBnL7BnV7BriBnB_YAjInBnaAjcA3IArEUrTA_TA7GAvHA3DUrOAvHAnGA_OA_TAnGUnkBAjIAzUAjrBArTA7QA3cA7LAjhB0UTsEA0UAgUAsnBAwRA0ZAwbAsYA4XA0rCU4NAoQUgKAgPAoLAgPAoVAoGA4cT0PAgKA0eA0jBU4hBAoVA0FA4DA4hBU8GAkIAwHAkhBAwHA7B_JnBjI7B_OrE_dTzF3DnanBjSTjIT_OAvHAnGArJAjNUj_BArdoB34CAjcU_xBT3rB7B_TzFvqBvC3NnBrJvCnQjI7kB3I_iBrE_iBnBjSrE_YvCvgBTrYArOArTT_dA3cUnpBA3SU3wBAjIA7lDA7LAzUoBzxJA7B7BrnBjI7mF7BnfnBnanB3cArJU3SUnf8BvRoB3NkDnL4DnQoBrE0K3XkNvWoLzP4IrJ4IrJ0K3I8B7BwW3SgoB3hBsTnQgjBrd4NjNwMzP4D_EoL3SgKnV4DjN4D7L8BzKwCnLAvCoBjN8BvW4S_EwMjD0ejI0FnB0ZrE0jBrEokBvCwCA8VA4IAw5BUoiCUsdU0kDoBs7BUkIAkkCA4cAgtBUoVA4rBU0ZAsEAgyBwCsdwCo9BsJo4BkI0FUgZ8BkSoBwMoBoQA4cA8VAoLAwWnBgUnBgKnBoLT4NnBgUjD0PvCof_E8V7BsYvCoavC4hBAsEA8LAsYAA8uBTo2C8QoB8L8BU_3DoBnG4DvCgFA6mBA");
    // for(int i=0;i<result.length;i++){
    //   var value = result[i].toString().replaceAll("lat: ", "").replaceAll("longitude: ", "").split("/");
    //   latLng.add(LatLng(double.parse(value[0]), double.parse(value[1])));
    // }

    // print(widget.latLngList.toString());
    //
    // for(int i=0;i<widget.latLngList.length;i++){
    //   latLng.add(LatLng(widget.latLngList[i].lat, widget.latLngList[i].lng));
    // }
    //
    // log("final $latLng");
    // log("final ${latLng.length}");
    // log("final ${latLng.length/2}");
    // log("final ${latLng[228]}");
    // // declared for loop for various locations
    // for(int i=0; i<latLng.length; i++){
    //   _markers.add(
    //     // added markers
    //       Marker(
    //         markerId: MarkerId(i.toString()),
    //         position: latLng[i],
    //         infoWindow: InfoWindow(
    //           title: 'HOTEL',
    //           snippet: '5 Star Hotel',
    //         ),
    //         icon: BitmapDescriptor.defaultMarker,
    //       )
    //   );
    //   // setState(() {
    //   //
    //   // });
    //
    // }
    // _polyline.add(
    //     Polyline(
    //       polylineId: PolylineId('1'),
    //       points: latLng,
    //       color: Colors.green,
    //     )
    // );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Color(0xFF0F9D58),
    //     // title of app
    //     title: Text("GFG"),
    //   ),
    //   body: Container(
    //     child: SafeArea(
    //       child: GoogleMap(
    //         //given camera position
    //         initialCameraPosition: _kGoogle,
    //         // on below line we have given map type
    //         mapType: MapType.normal,
    //         // specified set of markers below
    //         markers: _markers,
    //         // on below line we have enabled location
    //         myLocationEnabled: true,
    //         myLocationButtonEnabled: true,
    //         // on below line we have enabled compass location
    //         compassEnabled: true,
    //         // on below line we have added polylines
    //         polylines: _polyline,
    //         // displayed google map
    //         onMapCreated: (GoogleMapController controller){
    //           _controller.complete(controller);
    //         },
    //       ),
    //     ),
    //   ),
    // );


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
          var reasonPhrase = await provider?.uploadImage(file?.path, widget.url);
          await provider?.setState(reasonPhrase);

          // List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
          // print(placemarks);

          // GeoRange georange = GeoRange();
          // var encoded = georange.encode(-1.2862368,36.8195783);
          // print(encoded);

          // List<Point> decoded = georange.decode("BGs4xv-Bl7yw4FgFuF4D8B4DTwlB_sBwlBvqBsTrY4mB_sB8G7GgezjB4rB4wBsErEkhBzoB0PnV8GjIwM_OgjBvqBwM3I");
          // print(decoded.latitude);
          // PolylinePoints polylinePoints = PolylinePoints();
          // List<LatLng> latLng = [];
          // List<PointLatLng> result = polylinePoints.decodePolyline("BGs4xv-Bl7yw4FgFuF4D8B4DTwlB_sBwlBvqBsTrY4mB_sB8G7GgezjB4rB4wBsErEkhBzoB0PnV8GjIwM_OgjBvqBwM3I");
          // for(int i=0;i<result.length;i++){
          //   var value = result[i].toString().replaceAll("lat: ", "").replaceAll("longitude: ", "").split("/");
          //   latLng.add(LatLng(double.parse(value[0]), double.parse(value[1])));
          // }
          //
          // print(latLng);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}