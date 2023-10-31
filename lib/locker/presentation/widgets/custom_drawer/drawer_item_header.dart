import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/locker_provider.dart';
import 'drawer_subitem.dart';

class DrawerItemHeader extends StatelessWidget {
  final String title;
  final List<DrawerSubItem> subItems;
  const DrawerItemHeader({required this.title, required this.subItems});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<LockerProvider>(context);
    return ExpansionTile(
      title: Text(
        title,
        style: textTheme.bodyLarge,
      ),
      children: [
        for (final subItem in subItems)
          ListTile(
            title: Text(
              subItem.title,
              style: textTheme.bodyMedium,
            ),
            onTap: () {
              provider.selectedPage = subItem.title;
              provider.selectedMainPageTemp=title;
            },
          ),
      ],
    );
  }
}
