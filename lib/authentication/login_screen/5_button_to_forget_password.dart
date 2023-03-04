import 'package:diabetichero_app/authentication/forget_password_screen/forget_password_screen.dart';
import 'package:flutter/material.dart';

class ButtonToForgetPassword extends StatelessWidget {
  const ButtonToForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: const <Widget>[
          Icon(Icons.app_registration_outlined),
          Text(
            "Quên mật khẩu",
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 28, 27, 27),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ForgetPasswordScreen()));
      },
    );
  }
}
