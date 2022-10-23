
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  String? title;
  Loader({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpinKitRotatingCircle(color: Colors.orange, size: 50.0,),
        const SizedBox(height: 20,),
        Text(title!)
      ],
    );

  }
}
