import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/locker_provider.dart';
import '../shared/custom_button.dart';
import '../shared/page_title.dart';
import 'locker_widget.dart';

class ViewLocker extends StatelessWidget {
  const ViewLocker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<LockerProvider>(context);
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: Alignment.center,
                child: PageTitle(title: 'View Locker'),
              ),
              SizedBox(
                height: 8.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: Text("Scan the network and list below the found locker IDs",maxLines: 2,overflow: TextOverflow.ellipsis,style: textTheme.bodySmall,textAlign: TextAlign.center,)),
                  SizedBox(width: 1.w,),
                  CustomButton(title: "Scan",onPressed: ()async{
                    await provider.getLockers(context);
                  },),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = (constraints.maxWidth / 250).floor();
                  crossAxisCount = crossAxisCount.clamp(1, 4);
                 return GridView.builder(
                   physics: BouncingScrollPhysics(),

                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 0.5.h,
                          mainAxisSpacing: 0.5.w
                      ),
                      itemBuilder: (context, index) =>
                          LockerWidget(locker: provider.lockers[index]),
                      itemCount: provider.lockers.length);
                }

              ),

            ],
          ),
        ),
      ),
    );

  }
}
