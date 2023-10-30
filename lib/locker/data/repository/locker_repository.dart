import 'package:dartz/dartz.dart';
import 'package:locker_app/core/error/custom_err.dart';
import 'package:locker_app/core/usecase/base_usecase.dart';
import 'package:locker_app/locker/domain/entities/locker.dart';
import 'package:locker_app/locker/domain/repository/base_locker_repository.dart';

import '../../domain/usecases/add_locker.dart';
import '../datasource/base_locker_remote_datasource.dart';
import '../models/locker_model.dart';

class LockerRepository extends BaseLockerRepository {
  final BaseLockerRemoteDataSource lockerRemoteDataSource;
  LockerRepository({required this.lockerRemoteDataSource});

  @override
  Future<Either<CustomError, NoParams>> addLocker(LockerParams params) async {
    await lockerRemoteDataSource.addLocker(params);
    try {
      return Right (NoParams());
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }

  @override
  Future<Either<CustomError, List<Locker>>> getLockers() async {
    final result = await lockerRemoteDataSource.getLockers();
    try {
      return Right(result);
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
