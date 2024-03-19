

import 'package:flutter/material.dart';

import 'LinearLoader.dart';
import 'dot_type.dart';

class CommonApiLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1.0,
      child: Container(

        color: Colors.transparent,
        alignment: FractionalOffset.center,
        height:400,
        width: double.infinity,
        child: LinearLoader(
          dotOneColor: Colors.red,
          dotTwoColor: Colors.orange,
          dotThreeColor: Colors.green,
          dotType: DotType.circle,
          dotIcon: Icon(Icons.adjust),
          duration: Duration(seconds: 1),
        ),
      ),
    );
  }
}
