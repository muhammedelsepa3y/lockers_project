import 'package:locker_app/core/error/custom_err.dart';
import 'package:locker_app/locker/data/models/locker_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locker_app/locker/domain/entities/locker.dart';

import '../../domain/usecases/add_locker.dart';

abstract class BaseLockerRemoteDataSource {
  Future<List<LockerModel>> getLockers();

  Future<void> addLocker(LockerParams params);
}

class LockerRemoteDataSource implements BaseLockerRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addLocker(LockerParams params) async {
    try {

      await firestore.collection('lockers').add(LockerModel(
        id: params.id,
        location: params.location,
        numberOfCells: params.numberOfCells,
        reservationMode: params.reservationMode,
      ).toJson());
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  @override
  Future<List<LockerModel>> getLockers() async {


    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('lockers').get();
      List<LockerModel> lockersList = querySnapshot.docs.map((doc) => LockerModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      return lockersList;

    } catch (e) {
      throw CustomError(e.toString());
    }
  }
}
