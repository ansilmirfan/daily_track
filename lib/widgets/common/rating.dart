// ignore_for_file: library_private_types_in_public_api, must_be_immutable

// ignore: use_key_in_widget_constructors
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Rating extends StatefulWidget {
  BuildContext context;
  Rating({super.key, required this.context});
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rate this app"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("How would you rate our app?"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _rating >= 1 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = 1.0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  _rating >= 2 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = 2.0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  _rating >= 3 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = 3.0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  _rating >= 4 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = 4.0;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  _rating >= 5 ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _rating = 5.0;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(widget.context);
          },
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(widget.context);
          },
          child: const Text("Rate"),
        ),
      ],
    );
  }
}
