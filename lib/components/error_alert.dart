import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String error;

  const ErrorAlert({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
