import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> showPlatformMessage(BuildContext context, String message) async {
  if (kIsWeb) {
    // Use a Flutter dialog instead of browser alert
    await showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Message"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  } else {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
