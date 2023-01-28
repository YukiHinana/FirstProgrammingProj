import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt/post.dart';
import 'createPostPage.dart';
import 'package:http/http.dart' as http;

class MyPostPage extends StatefulWidget {
  const MyPostPage({super.key});

  @override
  State<MyPostPage> createState() => _MyPostPageState();

}

class _MyPostPageState extends State<MyPostPage> {

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

  Widget postListView() {
    Widget w = ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 20,
            child: Row(
              children: [
                Text(posts[index].title),
                Text(posts[index].author)
              ],
            ),
          );
        }
    );
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postListView(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const NewPostPage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}