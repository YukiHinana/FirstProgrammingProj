import 'package:flutter/material.dart';

class SinglePostPage extends StatelessWidget {
  final String title;
  final String body;
  const SinglePostPage({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("aaaa"),
      ),
      body: Column(
       
        children:[
           Padding(padding: const EdgeInsets.all(13.0),
          child: Container(
            width: 600.0,
            height:100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: const Color(0xFFFF9000).withOpacity(0.8),
              ),
              child: Center(
                child: Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
          ),
        ),
          
          Padding(
          padding: const EdgeInsets.all(13.0),
         
          child: Container(
            width: 600.0,
            height:650.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: const Color(0xFFFF9000).withOpacity(0.5),
              ),
             child: Center(
                child: Text(body,
                  style: TextStyle(fontStyle: FontStyle.italic),
              ),
             ),
          ),
        ),
        ]
      )
    );
  }
}