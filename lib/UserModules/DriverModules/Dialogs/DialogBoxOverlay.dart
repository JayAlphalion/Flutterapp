import 'dart:io';

import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogBoxOverlay extends StatefulWidget {
  const DialogBoxOverlay(
      {Key? key,
      required this.desc,
      this.primaryFunction,
      required this.title,
      required this.icon,
      required this.primaryActionText})
      : super(key: key);

  final Widget icon;
  final String title;
  final String desc;
  final String primaryActionText;
  final Function()? primaryFunction;

  static Future<T?> displaySuccessDialog<T>(
      {required BuildContext context,
      required final Function() primaryFunction}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBoxOverlay(
          title: "Success",
          desc: "Success Description",
          primaryActionText: "Success",
          icon: Icon(
            Icons.check_circle,
            color: AppColors.greenColor,
            size: 80,
          ),
          primaryFunction: primaryFunction,
        );
        // return AlertDialog(
        //   backgroundColor: Colors.white,
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(5))),
        //   contentPadding: const EdgeInsets.only(top: 10, bottom: 30),
        //   content: LogoutOverlay(
        //   ),
        // );
      },
    );
  }

  static Future<T?> displayFailureDialog<T>(
      {required BuildContext context,
      required final Function() primaryFunction}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBoxOverlay(
          title: "Failure",
          primaryActionText: "Failure",
          desc: "Failure Description",
          icon: Icon(
            Icons.cancel,
            color: AppColors.redColor,
            size: 80,
          ),
          primaryFunction: primaryFunction,
        );
      },
    );
  }

  static Future<T?> displayRetryDialog<T>(
      {required BuildContext context,
      required final Function() primaryFunction}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogBoxOverlay(
          title: "Retry",
          primaryActionText: "Retry",
          desc: "Retry Description",
          icon: Icon(
            Icons.replay_circle_filled_outlined,
            color: AppColors.greenColor,
            size: 80,
          ),
          primaryFunction: primaryFunction,
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() => DialogBoxOverlayState();
}

class DialogBoxOverlayState extends State<DialogBoxOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 250.0,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  widget.icon,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    widget.desc,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ButtonTheme(
                              height: 35.0,
                              child: MaterialButton(
                                color: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                splashColor: Colors.white.withAlpha(40),
                                child: Text(
                                  widget.primaryActionText,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: () {},
                              )),
                        ),
                      ),
                      // const SizedBox(width: 16),
                      // Expanded(
                      //   child: ButtonTheme(
                      //       height: 35.0,
                      //       child: MaterialButton(
                      //         color: Colors.white,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(5.0)),
                      //         splashColor: Colors.white.withAlpha(40),
                      //         child: const Text(
                      //           'Cancel',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 13.0),
                      //         ),
                      //         onPressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //       )),
                      // ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class ExitAppDialog extends StatefulWidget {
  const ExitAppDialog({Key? key}) : super(key: key);

  static Future<T?> displayDialog<T>({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ExitAppDialog();
      },
    );
  }

  @override
  State<ExitAppDialog> createState() => _ExitAppDialogState();
}

class _ExitAppDialogState extends State<ExitAppDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 200.0,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    size: 80,
                    color: AppColors.primaryColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'EXIT APP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ButtonTheme(
                            height: 35.0,
                            child: MaterialButton(
                              color: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              splashColor: Colors.white.withAlpha(40),
                              child: Text(
                                'EXIT',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                            )),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: ButtonTheme(
                            height: 35.0,
                            child: MaterialButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              splashColor: Colors.white.withAlpha(40),
                              child: const Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
