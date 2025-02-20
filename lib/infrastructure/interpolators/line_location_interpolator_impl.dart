import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animarker/core/i_interpolation_service_optimized.dart';
import 'package:flutter_animarker/core/i_lat_lng.dart';
import 'package:flutter_animarker/helpers/spherical_util.dart';

class LineLocationInterpolatorImpl<T extends ILatLng> extends IInterpolationServiceOptimized<T> {
  @override
  late T begin;
  @override
  late T end;
  final ILatLng _previousPosition = ILatLng.empty();
  late Float32x4 float32x4FromVector;
  late Float32x4 float32x4Delta;

  /// Create a interpolation from given [begin] and [end] values location points.
  LineLocationInterpolatorImpl({
    required T begin,
    required T end,
  })  : begin = begin,
        end = end, super.warmUp();

  @override
  bool get isStopped => begin == end;

  ILatLng get previousPosition => _previousPosition.isEmpty ? begin : _previousPosition;


  @override
  @protected
  void doSwap(T newValue) {
    begin = end;
    end = newValue.isEmpty ? end : newValue;
  }

  @override
  @protected
  void doWarmUp() {

    var fromVectorNormalized = SphericalUtil.toVector3(begin.latitude, begin.longitude).normalized();

    var toVectorNormalized = SphericalUtil.toVector3(end.latitude, end.longitude).normalized();

    float32x4FromVector = Float32x4(fromVectorNormalized.x, fromVectorNormalized.y, fromVectorNormalized.z, 0);

    var float32x4ToVector = Float32x4(toVectorNormalized.x, toVectorNormalized.y, toVectorNormalized.z, 0);

    float32x4Delta = float32x4ToVector - float32x4FromVector;
  }

  @override
  @protected
  T doInterpolate(double t) => SphericalUtil.vectorInterpolateOptimized(float32x4Delta, float32x4FromVector, t) as T;
}
