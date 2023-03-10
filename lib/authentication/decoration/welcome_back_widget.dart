import 'package:flutter/material.dart';

class WelcomeBackWidget extends StatelessWidget {
  const WelcomeBackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        " Chào mừng quay trở lại!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }
}
