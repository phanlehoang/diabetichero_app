// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diabetichero_app/presentation/widgets/status/internet_check_widgets.dart';
import 'package:flutter/material.dart';

import '1_nice_container.dart';

//nice screen
class NiceScreen extends StatelessWidget {
  final Widget child;
  const NiceScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetCheck(
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}

class SimpleScreen extends StatelessWidget {
  final Widget child;
  const SimpleScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double a = 2;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(a, a, a, a),
      child: child,
    );
  }
}
