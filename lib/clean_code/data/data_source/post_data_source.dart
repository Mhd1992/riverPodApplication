import 'dart:convert';

import 'package:riverpod_post_appilcation/clean_code/data/models/post_model.dart';
import 'package:http/http.dart' as http;
import '../../domain/entites/post_entity.dart';

class PostDataSource {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostEntity>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => PostEntity.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<PostEntity> addPost(PostEntity post) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return PostEntity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add post');
    }
  }

  Future<PostEntity> updatePost(PostEntity post) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return PostEntity.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}



/*other way to decode list
  final List decodedList = json.decode(response.body) as List;
      post = (decodedList.map<PostModel>((element) => PostModel.fromJson(element))).toList();
*/