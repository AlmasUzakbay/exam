import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_education/presentation/bloc/post/post_state.dart';
import 'package:flutter_education/presentation/widgets/postcard_widget.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: state.posts[index]);
              },
            );
          } else if (state is PostsError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No posts available'));
        },
      ),
    );
  }
}
