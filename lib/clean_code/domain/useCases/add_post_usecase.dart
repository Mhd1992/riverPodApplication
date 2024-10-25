import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';
import '../entites/failure.dart';
import '../entites/success.dart';

class AddPostUseCase {
  final PostRepository postRepository;

  AddPostUseCase(this.postRepository);

  Future<Either<Failure,Success>> call(PostEntity postModel ) {
    return postRepository.addPost(postModel);
  }
}
