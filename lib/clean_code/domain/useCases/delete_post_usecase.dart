import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';
import '../entites/failure.dart';
import '../entites/success.dart';

class DeletePostUseCase {
  final PostRepository postRepository;

  DeletePostUseCase(this.postRepository);

   Either<Failure,Success> call(String postId){
     return postRepository.deletePost(postId);
  }
}