import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ttt/allPostPage.dart';
import 'package:ttt/signup.dart';
import 'package:ttt/singlePostPage.dart';
import './login.dart';
import 'createPostPage.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      name: "home",
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const MyLoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const MySignupPage();
          },
        ),

      ],
    ),
    GoRoute(
      path: '/posts',
      builder: (BuildContext context, GoRouterState state) {
        return const MyPostPage();
      },
      routes: <RouteBase>[
        GoRoute(
            name: "createPost",
            path: 'create',
            builder: (BuildContext context, GoRouterState state) {
              return const NewPostPage();
            }
        ),
        GoRoute(
          path: 'view/:id',
          builder: (context, state) => SinglePostPage(postId: int.parse(state.params['id']!)),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.deepPurpleAccent),
        )
      ),
      // home: const MyLoginPage(),
      routerConfig: _router,
    );
  }
}

