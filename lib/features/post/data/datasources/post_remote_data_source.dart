import 'package:clean_architecture/core/databases/api/api_consumer.dart';
import 'package:clean_architecture/core/databases/api/end_points.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/post/data/models/post_model.dart';


class PostRemoteDataSource {
  final ApiConsumer api;

  PostRemoteDataSource({required this.api});
  Future<PostModel> getPost(PostParams params) async {
    final response = await api.get("${EndPoints.post}/${params.id}");
    return PostModel.fromJson(response);
  }
}
