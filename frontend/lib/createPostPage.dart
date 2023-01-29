import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'singlePostPage.dart';
import 'package:http/http.dart' as http;

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  late TextEditingController _postTitleController;
  late TextEditingController _postBodyController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _postTitleController = TextEditingController();
    _postBodyController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _postTitleController.dispose();
    _postBodyController.dispose();
  }

  Future<http.Response> createPostRequest() async {
    String token = (await _prefs).get("token").toString();
    var postData = json.encode(
        {
          'title': _postTitleController.text,
          'body': _postBodyController.text
        }
    );
    var response = await http.post(
        Uri.parse('http://appdemo.dns.codetector.org/posts/create'),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: postData
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: 'Title',
                        hintText: 'Enter the title'
                    ),
                    controller: _postTitleController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                        hintText: 'Enter the content'
                    ),
                    controller: _postBodyController,
                    maxLines: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: ElevatedButton(
                    onPressed: () {
                      createPostRequest();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SinglePostPage(
                              title: _postTitleController.text,
                              body: _postBodyController.text)));
                    },
                    child: const Text('Post'),
                  ),
                )
              ]
          ),)
    );
  }
}