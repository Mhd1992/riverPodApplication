import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/failure.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/success.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository postRepository;

  UpdatePostUseCase(this.postRepository);

  Either<Failure,Success> call(PostEntity postEntity){
    return postRepository.updatePost(postEntity);
  }
}