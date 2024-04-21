import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/data/repository/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostApi postApi;

  PostBloc({required this.postApi}) : super(PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostState> emit) async {
    emit(PostsLoading());
    try {
      final posts = await postApi.getPosts();
      emit(PostsLoaded(posts: posts));
    } catch (e) {
      emit(PostsError(message: e.toString()));
    }
  }
}
