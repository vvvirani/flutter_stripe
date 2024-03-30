import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader {
  Loader._();

  static Widget cupertinoActivityIndicator({double radius = 12, Color? color}) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radius,
        color: color,
      ),
    );
  }

  static void show(BuildContext context) {
    Navigator.push(context, _LoaderDialog());
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

class _LoaderDialog extends RawDialogRoute {
  _LoaderDialog()
      : super(
          barrierColor: Colors.black.withOpacity(0.2),
          pageBuilder: (context, animation, secondaryAnimation) {
            return PopScope(
              canPop: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Loader.cupertinoActivityIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        );
}
