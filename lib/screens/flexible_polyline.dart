

import 'package:multipart_example_2/screens/converter.dart';
import 'package:multipart_example_2/screens/latlngz.dart';
import 'package:tuple/tuple.dart';

class FlexiblePolyline {
  static final int version = 1;
  static final List<String> encodingTable =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_'
          .split('');
  static final String encodeString = "BGq335-Bj0ot4FJgCTwMAoVAwqBU8GkDsOgFsYoB0KUgPTk1BAsJkhBTwRA8GAwgBA0PAkXT0PA0ZAsEAgK8B0F8BwHwCwM4D4IkDA7LAzeA7GAjIAvWUjSAnGA7aUnVAnLArOAjDUrYAvRAzKUnQAnVAvHU3cAnVA3XoBnnCArTArJA_dAnBUjSA7BAjIAvgBA_JUjXA36BUzjBAzFAvHUj_BUrdUnfA_YAnaAjIUnVArYA7kBU_nBAnVAzKUjSA3IArYArJT7aAzFTzKAjSTzPTvbTvbTvbTjcAjXTrTArJUrYA3NUjSUrJwCrTkDjSoLzjBoG7Q8G7QkInQ4I7QkNrY8B3DgUjmB4I7QoBvCkDzFgoBzrC46BnvDoGnL4I7QsEjI4DnGwM3XsY7uB0ZvvB8LvWsxB39C8LvWkhB79BwHrOsJjSkIrOsE_JoG_OsEvMkDzKwC3IoBrE4DjSwC3SU_TAjIA7LAnQA_EAnVAzUAnVAnVA7VA3DAvRA3NA3STnVT7VAvgBAzKA3NUzjBU7lDAnfAvHArnBU_TwC_TkD_TsErTwCvHkDnL8G7VwCjIwCrJkD3NoBzFkDrT8BvRAzPA_EA_YU7aA_TTvlBUjIoB7awCnQkD7Q8B3IkD7L8GvW0FvR0F7QoB3DoL3hBsEjN8GnVoGnVwCnL8B7GkDjNoBrJ8B7LoBrOA3IAzPA7QAvHAzFA7GU3hB3D_qCnBrlCUjgEAjNA7QAvlBAzKArEArJU7kBAzUAjNA3cArsBU7nCUv0BAzeAnGA_EA3mBA7fT7uBAnQAjNA3DAvMAzUA3DAnQAzKA3IAzZA3NAjNAvCAnfAvWTvqBAjSAzFA7QA7GAjmBAvMAvCAzZAnVUjSA7GAjXArJTjN7B3XnBnL7BnV7BriBnB_YAjInBnaAjcA3IArEUrTA_TA7GAvHA3DUrOAvHAnGA_OA_TAnGUnkBAjIAzUAjrBArTA7QA3cA7LAjhB0UTsEA0UAgUAsnBAwRA0ZAwbAsYA4XA0rCU4NAoQUgKAgPAoLAgPAoVAoGA4cT0PAgKA0eA0jBU4hBAoVA0FA4DA4hBU8GAkIAwHAkhBAwHA7B_JnBjI7B_OrE_dTzF3DnanBjSTjIT_OAvHAnGArJAjNUj_BArdoB34CAjcU_xBT3rB7B_TzFvqBvC3NnBrJvCnQjI7kB3I_iBrE_iBnBjSrE_YvCvgBTrYArOArTT_dA3cUnpBA3SU3wBAjIA7lDA7LAzUoBzxJA7B7BrnBjI7mF7BnfnBnanB3cArJU3SUnf8BvRoB3NkDnL4DnQoBrE0K3XkNvWoLzP4IrJ4IrJ0K3I8B7BwW3SgoB3hBsTnQgjBrd4NjNwMzP4D_EoL3SgKnV4DjN4D7L8BzKwCnLAvCoBjN8BvW4S_EwMjD0ejI0FnB0ZrE0jBrEokBvCwCA8VA4IAw5BUoiCUsdU0kDoBs7BUkIAkkCA4cAgtBUoVA4rBU0ZAsEAgyBwCsdwCo9BsJo4BkI0FUgZ8BkSoBwMoBoQA4cA8VAoLAwWnBgUnBgKnBoLT4NnBgUjD0PvCof_E8V7BsYvCoavC4hBAsEA8LAsYAA8uBTo2C8QoB8L8BU_3DoBnG4DvCgFA6mBA";
  static final List<int> decodingTable = [
    62,
    -1,
    -1,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    -1,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    -1,
    -1,
    -1,
    -1,
    63,
    -1,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51
  ];

  ///
  /// Decode the encoded input {@link String} to {@link List} of coordinate
  /// triples.
  ///
  /// @param encoded URL-safe encoded {@link String}
  /// @return {@link List} of coordinate triples that are decoded from input
  ///
  /// @see FlexiblePolyline#getThirdDimension(String) getThirdDimension
  /// @see LatLngZ
  ///
  static List<LatLngZ> decode(String? encoded) {
    if (encoded == null || encoded.trim().isEmpty) {
      throw ArgumentError("Invalid argument!");
    }
    final List<LatLngZ> results = [];
    final _Decoder dec = _Decoder(encoded);
    LatLngZ? result;

    do {
      result = dec.decodeOne();
      if (result != null) results.add(result);
    } while (result != null);
    return results;
  }

  ///
  /// Encode the list of coordinate triples.<BR><BR>
  /// The third dimension value will be eligible for encoding only when
  /// ThirdDimension is other than ABSENT.
  /// This is lossy compression based on precision accuracy.
  ///
  /// @param coordinates {@link List} of coordinate triples that to be encoded.
  /// @param precision   Floating point precision of the coordinate to be
  /// encoded.
  /// @param thirdDimension {@link ThirdDimension} which may be a level,
  /// altitude, elevation or some other custom value
  /// @param thirdDimPrecision Floating point precision for thirdDimension value
  /// @return URL-safe encoded {@link String} for the given coordinates.
  ///
  static String encode(List<LatLngZ>? coordinates, int precision,
      ThirdDimension? thirdDimension, int thirdDimPrecision) {
    if (coordinates == null || coordinates.isEmpty) {
      throw ArgumentError("Invalid coordinates!");
    }
    if (thirdDimension == null) {
      throw ArgumentError("Invalid thirdDimension");
    }
    final _Encoder enc = _Encoder(precision, thirdDimension, thirdDimPrecision);
    final Iterator<LatLngZ> iter = coordinates.iterator;
    while (iter.moveNext()) {
      enc.add(iter.current);
    }
    return enc.getEncoded();
  }

  /**
   * ThirdDimension type from the encoded input {@link String}
   * @param encoded URL-safe encoded coordinate triples {@link String}
   * @return type of {@link ThirdDimension}
   */
  static ThirdDimension getThirdDimension(List<String> encoded) {
    int index = 0;
    Tuple2<int, int> headerResult =
        _Decoder.decodeHeaderFromString(encoded, index);
    final int header = headerResult.item1;
    return ThirdDimension.values[(header >> 4) & 7];
  }
}

/// Single instance for decoding an input request.
class _Decoder {
  final String encoded;
  late int index;
  late Converter latConverter;
  late Converter lngConverter;
  late Converter zConverter;
  late List<String> split;

  late int precision;
  late int thirdDimPrecision;
  late ThirdDimension thirdDimension;

  _Decoder(this.encoded) {
    index = 0;
    split = encoded.split('');
    _decodeHeader();
    latConverter = Converter(precision);
    lngConverter = Converter(precision);
    zConverter = Converter(thirdDimPrecision);
  }

  bool hasThirdDimension() => thirdDimension != ThirdDimension.ABSENT;

  void _decodeHeader() {
    final Tuple2<int, int> headerResult = decodeHeaderFromString(split, index);
    int header = headerResult.item1;
    index = headerResult.item2;
    precision = header & 15; // we pick the first 3 bits only
    header = header >> 4;

    thirdDimension =
        ThirdDimension.values[header & 7]; // we pick the first 4 bits only
    thirdDimPrecision = (header >> 3) & 15;
  }

  // Returns polyline header, new index in tuple.
  static Tuple2<int, int> decodeHeaderFromString(
      List<String> encoded, int index) {
    // Decode the header version
    final Tuple2<int, int> result =
        Converter.decodeUnsignedVarint(encoded, index);

    if (result.item1 != FlexiblePolyline.version)
      throw ArgumentError("Invalid format version");

    // Decode the polyline header
    return Converter.decodeUnsignedVarint(encoded, result.item2);
  }

  LatLngZ? decodeOne() {
    if (index == encoded.length) {
      return null;
    }
    final Tuple2<double, int> latResult =
        latConverter.decodeValue(split, index);
    index = latResult.item2;
    final Tuple2<double, int> lngResult =
        lngConverter.decodeValue(split, index);
    index = lngResult.item2;
    if (hasThirdDimension()) {
      final Tuple2<double, int> zResult = zConverter.decodeValue(split, index);
      index = zResult.item2;
      return LatLngZ(latResult.item1, lngResult.item1, zResult.item1);
    }
    return LatLngZ(latResult.item1, lngResult.item1);
  }
}

/// Single instance for configuration, validation and encoding for an input
/// request.
class _Encoder {
  final int precision;
  final ThirdDimension thirdDimension;
  final int thirdDimPrecision;
  late Converter latConverter;
  late Converter lngConverter;
  late Converter zConverter;
  String result = '';

  _Encoder(this.precision, this.thirdDimension, this.thirdDimPrecision) {
    latConverter = Converter(precision);
    lngConverter = Converter(precision);
    zConverter = Converter(thirdDimPrecision);
    encodeHeader();
  }

  void encodeHeader() {
    final int thirdDimensionValue = thirdDimension.index;

    /// Encode the `precision`, `third_dim` and `third_dim_precision` into one
    /// encoded char
    if (precision < 0 || precision > 15) {
      throw ArgumentError("precision out of range");
    }

    if (thirdDimPrecision < 0 || thirdDimPrecision > 15) {
      throw ArgumentError("thirdDimPrecision out of range");
    }

    if (thirdDimensionValue < 0 || thirdDimensionValue > 7) {
      throw ArgumentError("thirdDimensionValue out of range");
    }
    final double res =
        ((thirdDimPrecision << 7) | (thirdDimensionValue << 4) | precision)
            .toDouble();
    result += Converter.encodeUnsignedVarint(FlexiblePolyline.version);
    result += Converter.encodeUnsignedVarint(res.toInt());
  }

  void addTuple(double lat, double lng) {
    result += latConverter.encodeValue(lat);
    result += lngConverter.encodeValue(lng);
  }

  void addTriple(double lat, double lng, double z) {
    addTuple(lat, lng);
    if (thirdDimension != ThirdDimension.ABSENT) {
      result += zConverter.encodeValue(z);
    }
  }

  void add(LatLngZ? tuple) {
    if (tuple == null) {
      throw ArgumentError("Invalid LatLngZ tuple");
    }
    addTriple(tuple.lat, tuple.lng, tuple.z);
  }

  String getEncoded() => result.toString();
}
