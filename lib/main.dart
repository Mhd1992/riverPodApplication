import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'clean_code/presentaion/screens/home_screen.dart';
import 'clean_code/presentaion/screens/post_home_screen_two.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RiverPod Example',
      home: PostsListScreen(),
   //   home: HomeScreen(),
      // home: PPostScreen(),
    );
  }
}