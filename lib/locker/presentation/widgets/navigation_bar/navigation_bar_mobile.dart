import 'package:flutter/material.dart';
import 'package:locker_app/locker/presentation/widgets/navigation_bar/search_field.dart';
import 'package:sizer/sizer.dart';

import 'navbar_logo.dart';

class NavigationBarMobile extends StatefulWidget {
  const NavigationBarMobile({super.key});
  @override
  State<NavigationBarMobile> createState() => _NavigationBarMobileState();
}
class _NavigationBarMobileState extends State<NavigationBarMobile> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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
          Expanded(child: SizedBox()),
          SearchBarr(),
          SizedBox(width: 2.w,),
          IconButton(
            icon: const Icon(Icons.menu, size: 30,color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),

        ],
      ),
    );




  }
}
