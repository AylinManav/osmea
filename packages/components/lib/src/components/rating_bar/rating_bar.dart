// components/rating_bar/rating_bar.dart
import 'package:flutter/material.dart';
import 'package:osmea_components/src/core/row_widget.dart';

/// A lightweight, Bloc-free rating bar that renders based on the provided
/// `rating` value and reports user interactions via `onRatingChanged`.
class OsmeaRatingBar extends CoreRow {
  final int maxRating;
  final double rating;
  final double size;
  final Color color;
  final IconData filledIcon;
  final IconData halfFilledIcon;
  final IconData emptyIcon;
  final ValueChanged<double> onRatingChanged;

  const OsmeaRatingBar({
    super.key,
    this.maxRating = 5,
    required this.onRatingChanged,
    this.rating = 0.0,
    this.size = 40,
    this.color = Colors.amber,
    this.filledIcon = Icons.star,
    this.halfFilledIcon = Icons.star_half,
    this.emptyIcon = Icons.star_border,
  });

  void _handleInteraction(BuildContext context, Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox;
    final local = box.globalToLocal(globalPosition);
    double raw = local.dx / size;
    double rounded = (raw * 2).round() / 2;
    final newRating = rounded.clamp(0.0, maxRating.toDouble());
    onRatingChanged(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _handleInteraction(context, details.globalPosition),
      onHorizontalDragUpdate: (details) => _handleInteraction(context, details.globalPosition),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(maxRating, (index) {
          final idx = index.toDouble();
          if (idx + 1 <= rating) {
            return Icon(filledIcon, size: size, color: color);
          } else if (idx < rating) {
            return Icon(halfFilledIcon, size: size, color: color);
          } else {
            return Icon(emptyIcon, size: size, color: color.withOpacity(0.9));
          }
        }),
      ),
    );
  }
}