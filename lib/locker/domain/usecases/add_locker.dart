import 'package:dartz/dartz.dart';
import 'package:locker_app/core/usecase/base_usecase.dart';
import 'package:locker_app/locker/domain/entities/locker.dart';

import '../../../core/error/custom_err.dart';
import '../../../core/utils/enums.dart';
import '../repository/base_locker_repository.dart';

class AddLockerUseCase implements BaseUseCase<void, LockerParams> {
  final BaseLockerRepository repository;

  AddLockerUseCase(this.repository);

  @override
  Future<Either<CustomError, void>> call(LockerParams parameters) async {
    try {
      await repository.addLocker(parameters);
      return Right(parameters);
    } catch (e) {
      return Left(CustomError(e.toString()));
    }
  }
}
class LockerParams {
  final int id;
  final String location;
  final int numberOfCells;
  final ReservationMode reservationMode;
  LockerParams({
    required this.id,
    required this.location,
    required this.numberOfCells,
    required this.reservationMode,
  });
}