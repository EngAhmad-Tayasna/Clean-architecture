import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/post/domain/entities/post_entitiy.dart';
import 'package:clean_architecture/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';


class GetPost {
  final PostRepository repository;

  GetPost({required this.repository});

  Future<Either<Failure, PostEntity>> call({required PostParams params}) {
    return repository.getPost(params: params);
  }
}
