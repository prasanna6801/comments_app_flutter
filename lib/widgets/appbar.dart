import 'package:comments_app/themes/colorscheme.dart';
import 'package:flutter/material.dart';

class AppBarWidget {
  appbarWidget(BuildContext context, Color backgroundColor,
      {Color? titleColor, List<Widget> actionWidgets = const []}) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 90,
      backgroundColor: backgroundColor,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          "Comments",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color:
                  titleColor ?? Theme.of(context).colorScheme.primaryBlueColor),
        ),
      ),
      actions: actionWidgets,
    );
  }
}
