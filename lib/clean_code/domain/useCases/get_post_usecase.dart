import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/repositories/post_repository.dart';
import '../entites/failure.dart';
import '../entites/post_entity.dart';

class GetPostUseCase{
  final PostRepository postRepository;

  GetPostUseCase(this.postRepository);

  Either<Failure,List<PostEntity>>  call(){
    return postRepository.getPosts();
  }
}