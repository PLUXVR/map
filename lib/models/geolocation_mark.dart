import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GeolocationMark {
  double latitude;
  double longitude;
  Image image = Image.asset('assets/bpla.png');

  GeolocationMark({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() {
    return 'Ширина $latitude, Долгота $longitude';
  }
}
