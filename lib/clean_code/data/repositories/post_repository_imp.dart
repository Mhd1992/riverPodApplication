import 'package:dartz/dartz.dart';
import 'package:riverpod_post_appilcation/clean_code/data/data_source/post_data_source.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/failure.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/post_entity.dart';
import 'package:riverpod_post_appilcation/clean_code/domain/entites/success.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImp implements PostRepository {
   List<PostEntity> _posts = [];

  final PostDataSource postDataSource;


  PostRepositoryImp(this.postDataSource);

  @override
  Future<Either<Failure, Success>> addPost(PostEntity post) async {
    try {
       await postDataSource.addPost(post);
    /*  _posts.add(PostModel(
          userId: post.userId,id:post.id, title: post.title, body: post.body));*/
      return Right(Success(message: "the post add Done!"));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }
  @override
  Future<Either<Failure, Success>> deletePost(String postId) async{
    try {
    await  postDataSource.deletePost(int.parse(postId));
      return Right(Success(message: "Delete is Done"));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }
  @override
  Future<Either<Failure,List<PostEntity>>> getPosts() async {
    try {
     _posts = await postDataSource.fetchPosts();
      return Right(List.unmodifiable(_posts));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }
  @override
  Future<Either<Failure, Success>>updatePost(PostEntity post) async{
    try {
      final postModel = await postDataSource.updatePost(PostEntity(
        userId: post.userId,
        id: post.id,
        title: post.title,
        body: post.body,
      ));
      return Right(Success(message: "update is Done!"));
    /*  final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = PostModel(
            userId: post.userId, id: post.id,title:post.title, body: post.body);
        return Right(Success(message: "update is Done!"));*/

     // return Left(Failure(message: "the element is notFound"));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }
}

/*


with out using dartz
import 'package:post_app_riverpod/cleanCode/domain/entites/post_entity.dart';

import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImp implements PostRepository{
  final List<PostModel> _posts=[];
  @override
  void addPost(PostEntity post) {
    _posts.add(PostModel(id: post.id, title: post.title, desc: post.desc,email:post.email));

    // TODO: implement addPost
  }

  @override
  void deletePost(String postId) {
    _posts.removeWhere((post) => post.id == postId);
  }

  @override
  List<PostEntity> getPosts() {
    
  return List.unmodifiable(_posts);
  }

  @override
  void updatePost(PostEntity post) {
 //  PostEntity p = _posts.where((p)=>p.id==post.id).first;

    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = PostModel(id: post.id, title: post.title, desc: post.desc , email: post.email);
    }  }

}*/
