import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';

import '../entites/failure.dart';
import '../entites/success.dart';

class AddPostUseCase {
  final PostRepository postRepository;

  AddPostUseCase(this.postRepository);

  Either<Failure, Success> call(PostEntity postEntity) {
    return postRepository.addPost(postEntity);
  }
}
