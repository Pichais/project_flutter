import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: const Icon(
          Icons.dangerous,
          color: Colors.red,
          size: 65,
        ),
        title: const Text(
          'แจ้งเตือน',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(string),
      ),
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    ),
  );
}
