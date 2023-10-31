import 'package:flutter/material.dart';
import 'package:locker_app/locker/presentation/widgets/navigation_bar/search_field.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/route_constants.dart';
import '../../providers/locker_provider.dart';
import 'navbar_item.dart';
import 'navbar_logo.dart';

class NavigationBarDesktop extends StatelessWidget {
   NavigationBarDesktop({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LockerProvider>(context);
    return Container(
      padding: EdgeInsets.all( 2.h),
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const NavbarLogo(),
          Row(

            children:[
              Container(
                height: 25,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context,index)=> NavBarItem(title: provider.selectedItem.keys.toList()[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 3.w,),
                  itemCount:  provider.selectedItem.keys.toList().length,
                ),
              ),
              SearchBarr()
            ]
          )


        ],
      ),
    );
  }
}
