import 'package:flutter/material.dart';

class LoadingDialog {
  static showLoadingDialog(BuildContext context) {
    AlertDialog alertLoading = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: 20),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text('Loading...'),
          )
        ],
      ),
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alertLoading;
        });
  }

  static dismissDialog(BuildContext context) => Navigator.pop(context);
}
