import 'package:flutter/material.dart';

class MyPostPage extends StatelessWidget {
  const MyPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: const Text('Posts'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('back'),
        ),
      ),
    );
  }

}