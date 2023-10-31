import 'dart:math';

import 'package:flutter/material.dart';
import 'package:locker_app/locker/presentation/providers/locker_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/centered_view/centered_view.dart';
import '../../widgets/custom_drawer/custom_drawer.dart';
import '../../widgets/navigation_bar/navigation_bar.dart';
import 'page_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<LockerProvider>(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return Scaffold(
          drawer: (SizerUtil.deviceType == DeviceType.mobile)
              ? const CustomDrawer()
              : null,

          body: Stack(
            children: [
              Image.asset(
                "images/background.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100.h,
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    NavigationBarr(),
                    CenteredView(
                      child: PageContent()
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
