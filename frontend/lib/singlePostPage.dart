import 'package:flutter/material.dart';

class SinglePostPage extends StatelessWidget {
  final String title;
  final String body;
  const SinglePostPage({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('aaa'),
      ),
      body: Column(
        children: [
          Text(title),
          Text(body)
        ],
      )
    );
  }
}