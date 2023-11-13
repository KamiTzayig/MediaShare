import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color:  Colors.red,
      alignment: Alignment.center,
      width: size.width,
      child: Text("No Internet Connection", style: TextStyle(color: Colors.white, fontSize: 20),),
    );;
  }
}
