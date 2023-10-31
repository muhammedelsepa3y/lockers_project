import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/locker_provider.dart';
import '../navigation_bar/show_popup_menu.dart';
import 'drawer_subitem.dart';

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<LockerProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: provider.selectedItem.keys.toList().length,
      itemBuilder: (context, index) {
        provider.selectedItem.forEach((key, value) {
          if (key == provider.selectedItem.keys.toList()[index]) {
            if (value.length > 1) {
              return Exp;
            } else{
              return ListTile(
                  title: Text(
                  provider.selectedItem.keys.toList()[index],
          style: textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          ),
          ),);
            }
          }
        });
      }
          ListTile(
        title: Text(
          provider.selectedItem.keys.toList()[index],
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        onTap: () {
          provider.selectedItem.forEach((key, value) {
            if (key == provider.selectedItem.keys.toList()[index]) {
              if (value.length > 1) {
                showPopupMenu(context,
                    provider.selectedItem.keys.toList()[index], provider);
              } else {
                provider.selectedPage =
                    provider.selectedItem.keys.toList()[index];
                context.pop();
              }
            }
          });
        },
      ),
    );
  }
}
