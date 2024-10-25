import 'package:riverpod_post_appilcation/clean_code/domain/entites/failure.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/success.dart';

import '../entites/post_entity.dart';
import 'package:dartz/dartz.dart';
abstract class PostRepository{
  Either<Failure,List<PostEntity>> getPosts();
  Either<Failure,Success> addPost(PostEntity post);
  Either<Failure,Success>  updatePost(PostEntity post);
  Either<Failure,Success>  deletePost(String postId);
}

/*

with out using dartz lib

import '../entites/post_entity.dart';

abstract class PostRepository{
  List<PostEntity> getPosts();
  void addPost(PostEntity post);
  void updatePost(PostEntity post);
  void deletePost(String postId);
}*/
