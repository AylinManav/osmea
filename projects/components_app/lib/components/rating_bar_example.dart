import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RatingBarExample extends StatefulWidget {
  const RatingBarExample({super.key});

  @override
  State<RatingBarExample> createState() => _RatingBarExampleState();
}

class _RatingBarExampleState extends State<RatingBarExample> {
  // Demonstrate various features via stateful controls
  double _rating = 3.5;
  double _ratingAlt = 2.0;
  int _maxRating = 5;
  double _size = 40;
  Color _color = Colors.amber;
  bool _readOnly = false; // We'll wrap the bar with AbsorbPointer when true
  bool _useCustomIcons = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Bar Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Interactive Rating (uses setState)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Wrap with AbsorbPointer to demonstrate readOnly behavior
            AbsorbPointer(
              absorbing: _readOnly,
              child: OsmeaComponents.ratingBar(
                maxRating: _maxRating,
                initialRating: _rating,
                size: _size,
                color: _color,
                filledIcon: _useCustomIcons ? Icons.favorite : Icons.star,
                halfFilledIcon: _useCustomIcons ? Icons.favorite : Icons.star_half,
                emptyIcon: _useCustomIcons ? Icons.favorite_border : Icons.star_border,
                onRatingChanged: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),
            Text('Rating: $_rating', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),
            const Divider(),

            // Controls to demonstrate props
            _buildControls(),

            const SizedBox(height: 20),
            const Divider(),

            const SizedBox(height: 8),
            const Text('Second example: 10-star scale (separate state)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // A second rating bar showcasing a different maxRating
            AbsorbPointer(
              absorbing: false,
              child: OsmeaComponents.ratingBar(
                maxRating: 10,
                initialRating: _ratingAlt,
                size: 28,
                color: Colors.pinkAccent,
                onRatingChanged: (rating) => setState(() => _ratingAlt = rating),
              ),
            ),
            const SizedBox(height: 8),
            Text('Rating (10-scale): $_ratingAlt', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Max rating', style: TextStyle(fontSize: 14)),
            DropdownButton<int>(
              value: _maxRating,
              items: [3, 5, 7, 10].map((e) => DropdownMenuItem(value: e, child: Text('$e'))).toList(),
              onChanged: (v) => setState(() {
                _maxRating = v ?? 5;
                if (_rating > _maxRating) _rating = _maxRating.toDouble();
              }),
            ),
          ],
        ),

        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Size', style: TextStyle(fontSize: 14)),
            Expanded(
              child: Slider(
                min: 20,
                max: 64,
                divisions: 11,
                value: _size,
                label: '${_size.toInt()}',
                onChanged: (v) => setState(() => _size = v),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Color', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 12),
            _colorButton(Colors.amber),
            const SizedBox(width: 8),
            _colorButton(Colors.redAccent),
            const SizedBox(width: 8),
            _colorButton(Colors.blueAccent),
            const SizedBox(width: 8),
            _colorButton(Colors.green),
          ],
        ),

        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              const Text('Read only', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Switch(value: _readOnly, onChanged: (v) => setState(() => _readOnly = v)),
            ]),
            Row(children: [
              const Text('Custom icons', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Switch(value: _useCustomIcons, onChanged: (v) => setState(() => _useCustomIcons = v)),
            ]),
          ],
        ),

        const SizedBox(height: 12),
        const Text('Adjust rating with slider (demonstrates programmatic updates):', style: TextStyle(fontSize: 14)),
        Slider(
          min: 0,
          max: _maxRating.toDouble(),
          divisions: (_maxRating * 2), // allow half-star steps
          value: _rating,
          label: _rating.toString(),
          onChanged: (v) => setState(() {
            _rating = (v * 2).round() / 2; // snap to half steps
          }),
        ),
      ],
    );
  }

  Widget _colorButton(Color c) {
    return GestureDetector(
      onTap: () => setState(() => _color = c),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12),
        ),
      ),
    );
  }
}
