import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/locker_provider.dart';
import '../custom_drawer/drawer_subitem.dart';

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
              showPopupMenu(context, provider);
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

  void showPopupMenu(BuildContext context, LockerProvider provider) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position =
        button.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + button.size.height,
        position.dx + button.size.width,
        position.dy + button.size.height + 10.0, // Adjust the offset as needed
      ),
      items: <PopupMenuEntry<String>>[
        for (var i in provider.getSubPages(title))
          PopupMenuItem<String>(
            value: i,
            child: Text(i),
          ),
      ],
    ).then<void>((String? selected) {
      if (selected != null && selected.isNotEmpty) {
        provider.selectedMainPageTemp = title;
        provider.selectedPage = selected;
      }
    });
  }
}
