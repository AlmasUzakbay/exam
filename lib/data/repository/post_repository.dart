import 'package:dio/dio.dart';
import 'package:flutter_education/data/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_repository.g.dart';

@RestApi(baseUrl: "https://exam-37aa6-default-rtdb.firebaseio.com/")
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  @GET("/posts.json")
  Future<List<Post>> getPosts();
}
