import 'package:flutter/material.dart';

import 'constants/decoration.dart';

class Widgets{
   static Widget buildButton({required String text, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: decorationBorder,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          child: Text(text,style:midText,),
        ),
      ),
    );
  }

  static Widget lisTile(
      {required String title,
      required String subtitle,
      required String lText,
      required Function onTap}) {
    return ListTile(
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            lText,
            style: bigText
          ),
        ),
      ),
      title: Text(title,style: bigText ),
      subtitle: Text(subtitle,style: smallText.copyWith(color: Colors.grey),),
      trailing: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all( Colors.green),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ))),
        child:   Text('open',style: smallText,),
        onPressed: () {
          onTap();
        },
      ),
    );
  }

}