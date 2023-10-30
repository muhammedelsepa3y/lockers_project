import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locker_app/core/utils/enums.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entities/locker.dart';
import '../../providers/locker_provider.dart';
import '../shared/custom_input_field.dart';
import 'locker_widget.dart';

class AddLocker extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LockerProvider>(context);
    final textTheme=Theme.of(context).textTheme;
    return provider.isLoading?Center(
      child: CircularProgressIndicator (),
    ):Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 20.w,
          height: 80.h,
          child: ListView(

            children: [
              Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add New Locker',style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),),
                SizedBox(height: 4.h,),
                CustomInputField(
                  keyboardType: TextInputType.number,
                  title: 'Locker ID',
                  controller: provider.lockerIdController,
                  textinputformatter: [

                    FilteringTextInputFormatter.digitsOnly,

                  ],
                ),
                SizedBox(height: 2.h,),

                CustomInputField(
                  title: 'Locker Location',
                  controller: provider.lockerLocationController,
                ),
                SizedBox(height: 2.h,),
                CustomInputField(
                    keyboardType: TextInputType.number,
                    title: 'Num. of Cells',
                    controller: provider.lockerNumberOfCellsController,
                    textinputformatter: [

                      FilteringTextInputFormatter.digitsOnly,

                    ]
                ),
                SizedBox(height: 2.h,),
                DropdownButton<String>(
                  value: provider.selectedLockerType.toString() ,
                  items: [

                    DropdownMenuItem(
                      child: Text('Shared Reservation mode'),
                      value: ReservationMode.shared.toString(),
                    ),
                    DropdownMenuItem(
                      child: Text('Pre Assigned Reservation mode'),
                      value: ReservationMode.preAssigned.toString(),
                    ),
                  ],
                  onChanged: (value) {
                    provider.selectedLockerType = ReservationMode.values.firstWhere(
                            (element) => element.toString() == value);


                  },
                ),
              ],
            ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                        onPressed: () {

                          if (
                          provider.lockerNumberOfCellsController.text.isEmpty ||
                              provider.lockerLocationController.text.isEmpty ||
                              provider.lockerIdController.text.isEmpty

                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please Enter all information and make sure id and num of cells is integer"),
                                  backgroundColor: Colors.red,
                                )
                            );
                          }else{
                            provider.addLocker(Locker(
                              id: int.parse(provider.lockerIdController.text),
                              location: provider.lockerLocationController.text,
                              numberOfCells: int.parse(provider.lockerNumberOfCellsController.text),
                              reservationMode: provider.selectedLockerType,
                            ),context);
                          }

                        },
                        child: Text('Save')),
                    SizedBox(width: 2.w,),
                    ElevatedButton(

                        onPressed: () {
                          provider.lockerNumberOfCellsController.clear();
                          provider.lockerLocationController.clear();
                          provider.lockerIdController.clear();
                        },
                        child: Text('Cancel')),
                  ],
                ),
              )]
          ),
        ),

        Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 15.w,
                    child: Text("Scan the network and list below the found locker IDs",maxLines: 2,overflow: TextOverflow.visible,style: textTheme.bodySmall,textAlign: TextAlign.center,)),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () async{
                          await provider.getLockers(context);
                        },
                        child: Text('Scan')),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all( 2.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),

                        width: 15.w,
                        child: ListView.separated(
                            itemBuilder: (context,index)=>
                            LockerWidget(locker: provider.lockers[index]),
                            separatorBuilder:(context,index)=>SizedBox(height: 1.h,) ,
                            itemCount: provider.lockers.length),
                      ),
                    )
                  ],
                ),
              ],
            )


      ],
    );
  }
}
