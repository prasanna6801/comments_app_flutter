import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toastwidget {
  toastWidget(
      {required BuildContext context,
      required String text,
      bool isErrorToast = false}) {
    return toastification.showCustom(
      context: context,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 2),
      callbacks: ToastificationCallbacks(
        onTap: toastification.dismiss,
      ),
      overlayState: Overlay.of(context),
      builder: (context, holder) {
        return GestureDetector(
          onTap: () {
            toastification.dismiss(holder);
          },
          onHorizontalDragStart: (details) {
            toastification.dismiss(holder);
          },
          onLongPress: () {
            holder.pause();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isErrorToast
                      ? Theme.of(context).colorScheme.error
                      : Colors.green,
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Icon(
                    isErrorToast
                        ? Icons.error_outline_rounded
                        : Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 20),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      text,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      toastification.dismiss(holder);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ))
              ]),
            ),
          ),
        );
      },
    );
  }
}
