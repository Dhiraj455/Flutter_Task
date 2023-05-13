import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;

  const StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = .0,
      required this.color,
      this.size = 24});

  @override
  // ignore: library_private_types_in_public_api
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return Icon(
          index < widget.rating.floor()
              ? Icons.star
              : index < widget.rating.ceil()
                  ? Icons.star_half
                  : Icons.star_outline,
          color: widget.color,
          size: widget.size,
        );
      }),
    );
  }
}
