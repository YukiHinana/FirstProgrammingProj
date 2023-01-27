import 'package:flutter/material.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Image(image: const AssetImage(tWelcomeScreen), height: size.height * 0.2 ,),
              Text(tLoginTitle, style: Theme.of(context).textTheme.headlineLarge),
              Text(tLoginSubTitle, style: Theme.of(context).textTheme.bodyLarge,)
            ],
          )
        ),
      ),
    );
  }
}


