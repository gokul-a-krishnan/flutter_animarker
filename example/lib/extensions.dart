import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_animarker/core/i_lat_lng.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    show CameraPosition, CameraUpdate, LatLng, MarkerId;

extension GoogleMapLatLng on ILatLng {
  LatLng get toLatLng => LatLng(latitude, longitude);
}

extension LatLngInfoEx on LatLng {
  LatLngInfo toLatLngInfo(MarkerId markerId, [double bearing = 0]) => LatLngInfo(latitude, longitude, markerId, bearing: bearing);

  CameraUpdate get cameraPosition => CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 15,
          tilt: 0,
          bearing: 30,
          target: LatLng(latitude, longitude),
        ),
      );
}
