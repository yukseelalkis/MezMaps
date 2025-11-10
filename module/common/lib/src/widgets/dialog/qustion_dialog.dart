import 'package:common/src/core/base/dialog_base.dart';
import 'package:flutter/material.dart';

final class QuestionAnswer {
  QuestionAnswer({required this.response});

  /// Answer text
  final String response;
}

final class QuestionDialog extends StatefulWidget {
  const QuestionDialog({super.key, required this.title});

  final String title;

  static Future<QuestionAnswer?> show({
    required String title,
    required BuildContext context,
  }) async {
    return DialogBase.show<QuestionAnswer>(
      context: context,
      builder: (context) => QuestionDialog(title: title),
    );
  }

  @override
  State<QuestionDialog> createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  String _response = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(widget.title),
      content: TextField(onChanged: (value) => _response = value),
      actions: [
        IconButton(
          onPressed: () {
            if (_response.isEmpty) Navigator.of(context).pop();

            Navigator.of(context).pop(QuestionAnswer(response: _response));
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
