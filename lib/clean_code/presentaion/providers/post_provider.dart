import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_post_appilcation/clean_code/data/repositories/post_repository_imp.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/failure.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/success.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/useCases/add_post_usecase.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/useCases/delete_post_usecase.dart';
import '../../domain/useCases/get_post_usecase.dart';
import '../../domain/useCases/update_post_usecase.dart';
import 'package:http/http.dart' as http;

class PostNotifier extends StateNotifier<List<PostEntity>> {
/*  PostNotifier(this.getPostUseCase, this.addPostUseCase, this.deletePostUseCase,
      this.updatePostUseCase, super.state);*/

  PostNotifier(this.getPostUseCase, this.addPostUseCase, this.deletePostUseCase,
      this.updatePostUseCase)
      : super([]) {
    loadPosts();
  }


  bool isLoading = false;
  final GetPostUseCase getPostUseCase;
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  void loadPosts() {
    final result = getPostUseCase();
    result.fold(
      (failure) {
        // Handle failure (e.g., show a message)
        print(failure.message);
      },
      (posts) {
        state = posts;
      },
    );
  }

  void createPost(PostEntity post) {
    final result = addPostUseCase(post);
    result.fold(
      (failure) {
        Failure("faild");
      },
      (posts) {
        Success("Done!");
      },
    );
    loadPosts();
  }

  void updatePost(PostEntity post) {
    final result = updatePostUseCase(post);
    result.fold(
      (failure) {
        Failure("faild");
      },
      (posts) {
        Success("Done!");
      },
    );
    loadPosts();
  }

  void removePost(String id) {
    isLoading = true;
    final result = deletePostUseCase(id);

    result.fold(
      (failure) {
        Failure("faild");
      },
      (posts) {
        Success("Done!");
      },
    );

    loadPosts();
    isLoading = false;
  }
}

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImp();
});

final postProvider =
    StateNotifierProvider<PostNotifier, List<PostEntity>>((ref) {
  final repository = ref.read(postRepositoryProvider);
  return PostNotifier(GetPostUseCase(repository), AddPostUseCase(repository),
      DeletePostUseCase(repository), UpdatePostUseCase(repository));
});

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier(super.state);

  void changeLoadingState(bool value){
    state = value;
  }
}

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier(false);
});
//using with dealing with api
/*final postAsyncProvider = FutureProvider<List<PostEntity>>((ref)async {
  try {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/poss'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => PostEntity.fromJson(item)).toList();

    } else {
      throw Exception();
    }
  } catch (e) {
    rethrow;
  }
});*/

/*

with out using dartz lib
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_app_riverpod/cleanCode/data/repositories/post_repository_imp.dart';
import 'package:post_app_riverpod/cleanCode/domain/entites/post_entity.dart';
import 'package:post_app_riverpod/cleanCode/domain/repositories/post_repository.dart';
import 'package:post_app_riverpod/cleanCode/domain/useCases/add_post_usecase.dart';
import 'package:post_app_riverpod/cleanCode/domain/useCases/delete_post_usecase.dart';
import 'package:post_app_riverpod/cleanCode/domain/useCases/get_post_usecase.dart';
import '../../domain/useCases/update_post_usecase.dart';
import 'package:http/http.dart' as http;
class PostNotifier extends StateNotifier<List<PostEntity>> {
*/ /*

*/
/*  PostNotifier(this.getPostUseCase, this.addPostUseCase, this.deletePostUseCase,
      this.updatePostUseCase, super.state);*/ /*



  PostNotifier(this.getPostUseCase, this.addPostUseCase, this.deletePostUseCase,
      this.updatePostUseCase)
      : super([]){
    loadPosts();
  }
  final GetPostUseCase getPostUseCase;
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  void loadPosts() {
    state = getPostUseCase();
  }

  void createPost(PostEntity post) {
    addPostUseCase(post);
    loadPosts();
  }

  void updatePost(PostEntity post) {
    updatePostUseCase(post);
    loadPosts();
  }

  void removePost(String id) {
    deletePostUseCase(id);
    loadPosts();
  }
}

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImp();
});


final postProvider =
    StateNotifierProvider<PostNotifier, List<PostEntity>>((ref) {
  final repository = ref.read(postRepositoryProvider);
  return PostNotifier(GetPostUseCase(repository), AddPostUseCase(repository),
      DeletePostUseCase(repository), UpdatePostUseCase(repository));
});
//using with dealing with api
*/
/*final postAsyncProvider = FutureProvider<List<PostEntity>>((ref)async {
  try {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/poss'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => PostEntity.fromJson(item)).toList();

    } else {
      throw Exception();
    }
  } catch (e) {
    rethrow;
  }
});*/ /*
*/
/*

*/
