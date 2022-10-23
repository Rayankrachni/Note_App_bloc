
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Epmty extends StatelessWidget {

  Epmty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(Icons.hourglass_disabled_rounded,size: 40,),
        SizedBox(height: 20,),
        Text('No List is Existed',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
      ],
    );

  }
}
