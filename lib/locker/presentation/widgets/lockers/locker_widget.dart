import 'package:flutter/material.dart';
import 'package:locker_app/locker/domain/entities/locker.dart';
import 'package:sizer/sizer.dart';

class LockerWidget extends StatelessWidget {
  Locker locker;
  LockerWidget({required this.locker});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all( 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Id: ${locker.id}"),
          Text("Location: ${locker.location}"),
          Text("# Cells: ${locker.numberOfCells}"),
          Text(locker.reservationMode.name+" Reservation Mode")
        ],
      ),
    );
  }
}
