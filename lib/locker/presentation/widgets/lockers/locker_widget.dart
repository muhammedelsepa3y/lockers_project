import 'package:flutter/material.dart';
import 'package:locker_app/locker/domain/entities/locker.dart';
import 'package:sizer/sizer.dart';

class LockerWidget extends StatelessWidget {
  Locker locker;
  LockerWidget({required this.locker});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      borderOnForeground: true,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30.h ,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/background.jpg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Locker ID: ${locker.id}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w200, // Set font weight to 200
                    color: Colors.black,

                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Locker Location: ${locker.location}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w200, // Set font weight to 200
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Number of Cells: ${locker.numberOfCells}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w200, // Set font weight to 200
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  '${locker.reservationMode.name} Reservation Mode',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w200, // Set font weight to 200
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
