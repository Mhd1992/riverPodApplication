import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';

import '../../../data/data_source/post_data_source.dart';
import '../../../domain/repositories/post_repository.dart';
import 'api_service.dart';


final apiServiceProvider = Provider((ref) => ApiService());

final futurePostsProvider = FutureProvider<List<PostEntity>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.fetchPosts();
});

final createPostProvider = FutureProvider.family<PostEntity, PostEntity>((ref, post) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.createPost(post);
});

final updatePostProvider = FutureProvider.family<PostEntity, PostEntity>((ref, post) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.updatePost(post);
});

final deletePostProvider = FutureProvider.family<void, int>((ref, id) async {
  final apiService = ref.read(apiServiceProvider);
  await apiService.deletePost(id);
});