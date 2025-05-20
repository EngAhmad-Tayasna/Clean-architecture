import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/connection/network_info.dart';
import 'package:clean_architecture/core/databases/api/dio_consumer.dart';
import 'package:clean_architecture/core/databases/cache/cache_helper.dart';
import 'package:clean_architecture/core/params/params.dart';
import 'package:clean_architecture/features/user/data/data_sources/user_local_data_source.dart';
import 'package:clean_architecture/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:clean_architecture/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture/features/user/domain/usecase/get_user.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  eitherFailureOrUser(int id) async {
    emit(GetUserLoading());
    final failureOrUser = await GetUser(
      repository: UserRepositoryImpl(
        networkInfo: NetworkInfoImpl(DataConnectionChecker()),
        localDataSource: UserLocalDataSource(cache: CacheHelper()),
        remoteDataSource: UserRemoteDataSource(api: DioConsumer(dio: Dio())),
      ),
    ).call(params: UserParams(id: id.toString()));

    failureOrUser.fold(
      (failure) => emit(GetUserFailure(errMessage: failure.errMessage)),
      (user) => emit(GetUserSuccessfully(user: user)),
    );
  }
}
