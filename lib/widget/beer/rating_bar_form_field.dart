import 'package:flutter/material.dart';

class RatingBarFormField extends StatefulWidget {
  final int maxStars;
  final int currentRating;
  final ValueChanged<int> onRatingChanged;

  const RatingBarFormField({super.key,
    required this.maxStars,
    required this.currentRating,
    required this.onRatingChanged,
  });

  @override
  RatingBarFormFieldState createState() => RatingBarFormFieldState();
}

class RatingBarFormFieldState extends State<RatingBarFormField> {
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.currentRating;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> starWidgets = List.generate(
      widget.maxStars,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedRating = index + 1;
          });
          widget.onRatingChanged(_selectedRating);
        },
        child: Icon(
          index < _selectedRating ? Icons.star : Icons.star_border,
          color: index < _selectedRating ? Colors.amber : Colors.grey,
          size: 48,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: starWidgets,
    );
  }
}
