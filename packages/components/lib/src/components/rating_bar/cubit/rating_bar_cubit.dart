import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'rating_bar_state.dart';

class RatingBarCubit extends Cubit<RatingBarState> {
  // Initialize state with the provided initial rating.
  RatingBarCubit({required double initialRating}) 
      : super(RatingBarState(rating: initialRating));

  void updateRating(double rating) {
    emit(state.copyWith(rating: rating));
  }

  // Core method to calculate the rating based on a global touch position.
  void calculateRating(Offset globalPosition, RenderBox box, double size, int maxRating) {
    final localPosition = box.globalToLocal(globalPosition);
    // localPosition.dx: the touched x-coordinate
    // size: the width (or height) of a single icon
    // The rating is computed as how many icon widths the touch covers.
    final rating = localPosition.dx / size;

    // For half-star precision: round to the nearest 0.5.
    // (rating * 2) produces values near integers.
    // .round() rounds to the nearest integer
    // / 2 converts back to 0.0, 0.5, 1.0, 1.5, etc.
    final roundedRating = (rating * 2).round() / 2;

    // Clamp the value between 0.0 and maxRating.
    final newRating = roundedRating.clamp(0.0, maxRating.toDouble());

    emit(state.copyWith(rating: newRating));
  }
}