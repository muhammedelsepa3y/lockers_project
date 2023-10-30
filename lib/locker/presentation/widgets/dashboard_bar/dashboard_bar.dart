import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/locker_provider.dart';
import '../navigation_bar/navbar_item.dart';
import 'dashboard_item.dart';

class DashboardBar extends StatelessWidget {
  const DashboardBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LockerProvider>(context);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all( 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      height: 8.h,
      width: 100.w,
      child:ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        itemBuilder: (context,index)=> DashboardItem(title: provider.selectedItem.keys.toList()[index]),
          separatorBuilder: (context,index)=>SizedBox(width: 5.w,),
          itemCount: provider.selectedItem.keys.toList().length,
      ),


    );
  }
}
