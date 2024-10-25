import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/failure.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/success.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';

import '../../data/models/post_model.dart';

class UpdatePostUseCase {
  final PostRepository postRepository;

  UpdatePostUseCase(this.postRepository);

  Future<Either<Failure,Success>> call(PostEntity postModel){
    return postRepository.updatePost(postModel);
  }
}