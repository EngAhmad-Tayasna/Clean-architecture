import 'package:clean_architecture/core/connection/network_info.dart';
import 'package:clean_architecture/core/errors/expentions.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/post/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture/features/post/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture/features/post/domain/entities/post_entitiy.dart';
import 'package:clean_architecture/features/post/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl extends PostRepository {
  final NetworkInfo networkInfo;
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, PostEntity>> getPost({
    required PostParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remotePost = await remoteDataSource.getPost(params);
        localDataSource.cachePost(remotePost);
        return Right(remotePost);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      try {
        final localPost = await localDataSource.getLastPost();
        return Right(localPost);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.errorMessage));
      }
    }
  }
}
