import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ttt/signup.dart';
import 'package:ttt/post.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();

}

class _MyLoginPageState extends State<MyLoginPage> {
 late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> sendLoginRequest() async {
    var loginData = json.encode(
        {
          'username': _usernameController.text,
          'password': _passwordController.text
        }
    );
    var response = await http.post(
        Uri.parse('http://appdemo.dns.codetector.org/account/login'),
        headers: {"Content-Type": "application/json"},
        body: loginData
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final SharedPreferences prefs = await _prefs;
    if (responseData['success']) {
      (prefs).setString("token", responseData['data']);
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child: const Text('Login'),
                onPressed: () {
                  Future<http.Response> re = sendLoginRequest();
                  re.then((value) {
                    // redirect to next page on success
                    if (jsonDecode(value.body)['success']) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyPostPage()),
                      );
                    } else {
                      // if incorrect username or password, pop alert window
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Login Failed'),
                            content: Text(jsonDecode(value.body)['data']),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'))
                            ],
                          )
                      );
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('SignUp'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MySignupPage()),
                  );
                },
              ),
            ),
          ]
      ),
    );
  }
}
