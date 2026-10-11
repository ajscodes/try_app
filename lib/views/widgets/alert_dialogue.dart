import 'package:flutter/material.dart';
import '../../utils/color_constants.dart';
import '../../utils/string_constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmColor;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.cancelText = AlertDialogue.cancel,
    this.confirmText = AlertDialogue.delete,
    this.onCancel,
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.pop(context),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(
            confirmText,
            style: TextStyle(
              color: confirmColor ?? ColorConstants.redPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
