import 'package:flutter/material.dart';

import '../../providers/locker_provider.dart';

void showPopupMenu(BuildContext context,String title, LockerProvider provider) {
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