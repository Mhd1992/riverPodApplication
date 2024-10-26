import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_post_appilcation/clean_code/presentaion/screens/update_post_screen.dart';

import '../providers/post_future_provider/future_post_provider.dart';
import '../providers/post_provider.dart';


class PostsListScreen extends ConsumerWidget {
  const PostsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(futurePostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
          /*    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPostScreen()),
              );*/
            },
          ),
        ],
      ),
      body: postsAsyncValue.when(
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(processPhrase(post.title),style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('${post.body.substring(0,70)}...'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdatePostScreen(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );

  }
}


  String processPhrase(String phrase) {
    // Split the phrase by spaces
    List<String> parts = phrase.split(' ');

    // Check if there are more than 3 spaces (which means more than 4 parts)
    if (parts.length > 4) {
      // Join the first 4 parts back into a string, separated by spaces
      return parts.take(4).join(' ');
    } else {
      // Return the original phrase if there are not enough spaces
      return phrase;
    }
  }

