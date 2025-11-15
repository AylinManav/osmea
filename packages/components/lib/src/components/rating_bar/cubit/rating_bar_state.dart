
import 'package:flutter/material.dart';

class RatingBarState {
  final double rating;

  const RatingBarState({this.rating = 0.0});

  RatingBarState copyWith({
    double? rating,
  }) {
    return RatingBarState(
      rating: rating ?? this.rating,
    );
  }
}
