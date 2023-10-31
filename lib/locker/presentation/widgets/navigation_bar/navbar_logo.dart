import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:locker_app/core/utils/app_assets.dart';
import 'package:sizer/sizer.dart';

class NavbarLogo extends StatelessWidget {
  const NavbarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Image.asset(AppAssets.logo, height: 25,color: Colors.white,),
        SizedBox(
          width: 1.w,
        ),
        Text(
          "IMBoX LMS",
          style: textTheme.headlineMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
