import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  final String icon;

  CircleButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // if (MediaQuery.of(context).orientation ==
        //     Orientation.portrait) {
        //   SystemChrome.setPreferredOrientations(
        //       [DeviceOrientation.landscapeLeft]);
        // } else {
        //   SystemChrome.setPreferredOrientations(
        //       [DeviceOrientation.portraitUp]);
        // }
      },
      shape: const CircleBorder(),
      backgroundColor: const Color.fromRGBO(27, 28, 34, 1.0),
      child: SvgPicture.asset(
        icon,
        height: 32,
        width: 32,
      ),
    );
  }
}
