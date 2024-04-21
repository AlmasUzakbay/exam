import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  final String id;
  final String title;
  final String? imageUrl;
  final String description;

  Post({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
