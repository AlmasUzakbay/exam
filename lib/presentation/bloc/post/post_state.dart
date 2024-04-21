import 'package:flutter_education/data/models/post_model.dart';

abstract class PostState {}

class PostsInitial extends PostState {}

class PostsLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> posts;

  PostsLoaded({required this.posts});
}

class PostsError extends PostState {
  final String message;

  PostsError({required this.message});
}
