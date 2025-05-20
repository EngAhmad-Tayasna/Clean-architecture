import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/post/domain/entities/post_entitiy.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, PostEntity>> getPost({required PostParams params});
}
