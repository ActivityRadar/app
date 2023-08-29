import 'dart:math';

/// https://stackoverflow.com/questions/62818403/flutter-google-maps-dynamically-zoom-in-and-out-with-radius-circle
double getZoomLevel(double radius, {double scale = 250}) {
  double zoomLevel = 11;
  if (radius > 0) {
    double radiusElevated = radius + radius / 2;
    double scale_ = radiusElevated / scale;
    zoomLevel = 16 - log(scale_) / log(2);
  }
  return zoomLevel;
}
