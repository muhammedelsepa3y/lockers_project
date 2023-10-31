import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:locker_app/core/error/custom_err.dart';
import 'package:locker_app/core/utils/route_constants.dart';
import 'package:locker_app/locker/domain/entities/locker.dart';
import 'package:locker_app/locker/domain/usecases/get_lockers_list.dart';

import '../../../core/usecase/base_usecase.dart';
import '../../../core/utils/enums.dart';
import '../../domain/usecases/add_locker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../widgets/dashboard/dashboard_home.dart';
import '../widgets/lockers/add_locker.dart';
import '../widgets/lockers/manage_locker.dart';
import '../widgets/lockers/view_locker.dart';
import '../widgets/manage/manage_home.dart';
import '../widgets/navigation_bar/navbar_item.dart';
import '../widgets/users/users_home.dart';


class LockerProvider extends ChangeNotifier {
  final GetLockersListUseCase _getLockersListUseCase;
  final AddLockerUseCase _addLockerUseCase;

  LockerProvider( this._getLockersListUseCase,  this._addLockerUseCase);

  final List<Locker> _lockers = [];

  List<Locker> get lockers => _lockers;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late CustomError _error;
  bool _isError = false;

  bool get isError => _isError;

  CustomError get error => _error;
  String _selectedMainPage = "Lockers";
  String get selectedMainPage => _selectedMainPage;
  String _selectedSubPageText="Add Locker";
  String get selectedSubPageText => _selectedSubPageText;
  Widget _selectedSubPage = AddLocker();
  String _selectedMainPageTemp="Lockers";
  set selectedMainPageTemp(String page) {_selectedMainPageTemp = page;}

  set selectedPage(String page) {
    bool isFound = false;
    _selectedItem.forEach((key, value) {
      if (key == page) {
        _selectedMainPage = key;
        _selectedSubPage = value[0].values.first;
        isFound = true;
      }
    });
    if (!isFound) {

      _selectedItem[_selectedMainPageTemp].forEach((element) {
        if (element.keys.first == page) {
          _selectedSubPage = element.values.first;
          _selectedSubPageText=element.keys.first;
        }
      });
    }
    notifyListeners();
  }
  Widget get selectedSubPage => _selectedSubPage;

  List<String> getSubPages (String main){
    List <String> subPages=[];
     _selectedItem[main].forEach((element) {
        subPages.add(element.keys.first);
     });
     return subPages;
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await http.get(Uri.parse('www.google.com'));
      if(result.statusCode==200){
        return true;
      }
      else{
        return false;
      }
    }
    on SocketException catch (_) {
      return false;
    }
  }

  final Map<String, dynamic> _selectedItem = {
    "Dashboard": [
      {"Home": DashboardHome()}
    ],
    "Users": [
      {"Home": UsersHome()},
    ],
    "Lockers": [
      {"Add Locker": AddLocker()},
      {"Manage Locker": ManageLocker()},
      {"View Locker": ViewLocker()},
    ],
    "Manage": [
      {"Home": ManageHome()},
    ],
  };

  Map<String, dynamic> get selectedItem => _selectedItem;

  Future getLockers(BuildContext context) async {
    if (await hasNetwork()) {
      _isLoading = true;
      notifyListeners();
      final result = await _getLockersListUseCase.call(NoParams());
      result.fold((l) {
        _isLoading = false;
        _error = l;
        _isError = true;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("there is err"),
              backgroundColor: Colors.red,
            )
        );
        notifyListeners();
      }, (r) {
        _lockers.clear();
        _lockers.addAll(r);

        _isLoading = false;
        notifyListeners();
      });
    } else {
      _error = CustomError("No internet connection");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
            backgroundColor: Colors.red,
          )
      );
      notifyListeners();
    }
  }

  Future addLocker(Locker locker,BuildContext context) async {
    if (await hasNetwork()) {
      _isLoading = true;
      notifyListeners();
      final result = await _addLockerUseCase.call(LockerParams(
          id: locker.id,
          location: locker.location,
          numberOfCells: locker.numberOfCells,
          reservationMode: locker.reservationMode));
      result.fold((l) {
        _isLoading = false;
        _isError=true;
        _error = l;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("there is err"),
              backgroundColor: Colors.red,
            )
        );
        notifyListeners();
      }, (r) {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("success"),
              backgroundColor: Colors.green,
            )
        );
        notifyListeners();
      });
    } else {
      _error = CustomError("No internet connection");
      _isError=true;
      _isLoading=false;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
            backgroundColor: Colors.red,
          )
      );
      notifyListeners();
    }
  }

  ReservationMode _selectedLockerType=ReservationMode.shared;
  set selectedLockerType (ReservationMode value){
    _selectedLockerType=value;
    notifyListeners();
  }
  ReservationMode get selectedLockerType => _selectedLockerType;

  TextEditingController lockerIdController = TextEditingController();
  TextEditingController lockerNumberOfCellsController = TextEditingController();
  TextEditingController lockerLocationController = TextEditingController();
}
