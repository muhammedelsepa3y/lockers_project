import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/locker_provider.dart';
import '../custom_drawer/drawer_subitem.dart';
import 'show_popup_menu.dart';

class NavBarItem extends StatelessWidget {
  final String title;

  NavBarItem({required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<LockerProvider>(context);
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onTap: () {
        provider.selectedItem.forEach((key, value) {
          if (key == title) {
            if (value.length > 1)
              showPopupMenu(context,title, provider);
            else
              provider.selectedPage = title;
          }
        });
      },
      child: Text(
        title,
        style: (provider.selectedMainPage == title ||
                provider.selectedSubPageText == title)
            ? textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w900, color: Colors.green)
            : textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
      ),
    );
  }


}
