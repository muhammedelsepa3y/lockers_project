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
    final textTheme = Theme.of(context).textTheme;
    return provider.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: Card(

              elevation: 20,
              borderOnForeground: true,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),


              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add New Locker',
                        style: textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomInputField(
                        keyboardType: TextInputType.number,
                        title: 'Locker ID',
                        controller: provider.lockerIdController,
                        textinputformatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomInputField(
                        title: 'Locker Location',
                        controller: provider.lockerLocationController,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomInputField(
                          keyboardType: TextInputType.number,
                          title: 'Num. of Cells',
                          controller: provider.lockerNumberOfCellsController,
                          textinputformatter: [
                            FilteringTextInputFormatter.digitsOnly,
                          ]),
                      SizedBox(
                        height: 2.h,
                      ),
                      DropdownButton<String>(
                        value: provider.selectedLockerType.toString(),
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
                          provider.selectedLockerType = ReservationMode.values
                              .firstWhere(
                                  (element) => element.toString() == value);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (provider.lockerNumberOfCellsController.text
                                          .isEmpty ||
                                      provider.lockerLocationController.text
                                          .isEmpty ||
                                      provider.lockerIdController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Please Enter all information and make sure id and num of cells is integer"),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    provider.addLocker(
                                        Locker(
                                          id: int.parse(
                                              provider.lockerIdController.text),
                                          location: provider
                                              .lockerLocationController.text,
                                          numberOfCells: int.parse(provider
                                              .lockerNumberOfCellsController
                                              .text),
                                          reservationMode:
                                              provider.selectedLockerType,
                                        ),
                                        context);
                                  }
                                },
                                child: Text('Save')),
                            SizedBox(
                              width: 2.w,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  provider.lockerNumberOfCellsController.clear();
                                  provider.lockerLocationController.clear();
                                  provider.lockerIdController.clear();
                                },
                                child: Text('Cancel')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
