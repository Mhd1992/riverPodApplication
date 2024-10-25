import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/presentaion/providers/post_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../widgets/cl_post_form_screen.dart';
import '../widgets/post_list_item.dart';

class ClHomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);
    final deleted = ref.watch(loadingProvider);

    //final postAsync = ref.watch(postAsyncProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: (deleted)
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty?const Center(child: Text('noData'),): ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostListItem(
            post: post,
            onDelete: () async {
              ref.read(loadingProvider.notifier).changeLoadingState(true);
              await Future.delayed(const Duration(seconds: 3));
              ref.read(postProvider.notifier).removePost(post.id);
              ref.read(loadingProvider.notifier).changeLoadingState(false);
            },
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ClPostFormScreen(post: post),
              ),
            ),
          );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ClPostFormScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );

  }

  void _showMessageDialog(BuildContext context, String message) {

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('title'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () async {
                  CircularProgressIndicator();
                  await Future.delayed(const Duration(seconds: 2));

                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
