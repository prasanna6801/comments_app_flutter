import 'package:comments_app/themes/colorscheme.dart';
import 'package:comments_app/themes/texttheme.dart';
import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget(
      {required this.actionText,
      required this.buttonText,
      required this.hintText,
      required this.buttonPressedCallback,
      required this.textPressedCallback,
      super.key});
  final String buttonText;
  final String hintText;
  final String actionText;
  final VoidCallback buttonPressedCallback;
  final VoidCallback textPressedCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(180, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor:
                    Theme.of(context).colorScheme.primaryBlueColor),
            onPressed: buttonPressedCallback,
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.regularTextStyle(
                    context,
                    textColor: Colors.white,
                    fontweight: FontWeight.w700,
                  ),
            )),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(hintText,
              style: Theme.of(context).textTheme.regularTextStyle(context)),
          GestureDetector(
            onTap: textPressedCallback,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: Text(actionText,
                  style: Theme.of(context).textTheme.regularTextStyle(context,
                      fontweight: FontWeight.w700,
                      textColor:
                          Theme.of(context).colorScheme.primaryBlueColor)),
            ),
          )
        ])
      ],
    );
  }
}
