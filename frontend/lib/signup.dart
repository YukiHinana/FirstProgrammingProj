import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MySignupPage extends StatefulWidget {
  const MySignupPage({super.key});

  @override
  State<MySignupPage> createState() => _MySignupState();
}

class _MySignupState extends State<MySignupPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

 Future<http.Response> sendSignupRequest() async {
    var signupData = json.encode(
        {
          'username': _usernameController.text,
          'password': _passwordController.text
        }
    );
    var response = await http.post(
        Uri.parse('http://128.61.24.205:8080/account/login'),
        headers: {"Content-Type": "application/json"},
        body: signupData
    );
    final responseData = jsonDecode(response.body);
    print(response.body);
    return response;
  }
   @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }
   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Test Login Page'),
      ),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'UserName',
                    hintText: 'Enter the username'
                ),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter the password'
                ),
                controller: _passwordController,
              ),
            ),
          
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('SignUp'),
                onPressed: () {
                  sendSignupRequest();
                },
              ),
            ),
          ]
    ),
    );
  }
}