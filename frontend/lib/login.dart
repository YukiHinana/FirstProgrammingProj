import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ttt/signup.dart';
import 'package:ttt/post.dart';
const String tWelcomeScreen = "/Users/jessiezhao/Documents/github/FirstProgrammingProj/frontend/Assets/tWelcomeScreen.png";


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
        Uri.parse('http://128.61.24.205:8080/account/login'),
        headers: {"Content-Type": "application/json"},
        body: loginData
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final SharedPreferences prefs = await _prefs;
    (prefs).setString("token", responseData['data']);
    return response;
  }

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
    (await _prefs).setString("token", responseData['data']);
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
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
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
                child: const Text('Login'),
                onPressed: () {
                  Future<http.Response> re = sendLoginRequest();
                  re.then((value) {
                    if (jsonDecode(value.body)['success']) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyPostPage()),
                      );
                    }
                  });
                },
              ),
            ),
              SizedBox(height: 10),

            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('SignUp'),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MySignupPage()),
                                );
                },
                 ),
            ),
            Image(image: const AssetImage(tWelcomeScreen), height: size.height * 0.2 ,),

          ]
      ),
      
    );
  }
}
