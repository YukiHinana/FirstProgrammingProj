import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt/post.dart';
import 'createPostPage.dart';
import 'package:http/http.dart' as http;

class YourPostPage extends StatefulWidget {
  const YourPostPage({super.key});

  @override
  State<YourPostPage> createState() => _YourPostPageState();

}

class _YourPostPageState extends State<YourPostPage> {

  Future<http.Response> getAllPostRequest() async {
    var response = await http.get(
        Uri.parse('http://appdemo.dns.codetector.org/posts/'),
        headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<List<Post>> getPosts() async {
    List<Post> postList = [];
    http.Response re = await getAllPostRequest();
    if (jsonDecode(re.body)['success']) {
      for (var info in jsonDecode(re.body)['data'] as List<dynamic>) {
        postList.add(Post.fromJson(info));
      }
    }
    return postList;
  }

  List<Post> posts = [];
  @override
  void initState() {
    getPosts().then((value) {
      setState(() {
        posts = value;
      });
    });
  }
  
  //  Widget YourPostView() {
    
   
  //  }

  @override
  Widget build(BuildContext context) {
    // var body = getAllPostRequest.body() ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                  padding: const EdgeInsets.all(13.0),
                  // child: Text(posts.body),
            ),
        ]
        ),
      )
    );
    }

 
  
}