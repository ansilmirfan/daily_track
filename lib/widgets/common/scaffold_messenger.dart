import 'package:flutter/material.dart';

snackbarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
