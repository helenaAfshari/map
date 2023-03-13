

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/dimens.dart';

class MyBackButton extends StatelessWidget {
  
  Function() onPressed;
  MyBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
    top: Dimens.medium,
    left: Dimens.medium,
    
    child: Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
           color: Colors.black,
           offset: Offset(2, 3),
           blurRadius: 18,

        )]
      ),
      child:IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_back)) ,
    )
          );
  }
}