import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  void Function()? onPressed;
  CustomButton({required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(title,style: textTheme.bodySmall?.copyWith(color: Colors.white),),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
