import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CustomInputField extends StatelessWidget {
  String title;
  TextEditingController controller;
  TextInputType? keyboardType= TextInputType.text;
  List<TextInputFormatter>? textinputformatter;
  CustomInputField({
    required this.title,
    required this.controller,
    this.keyboardType,
    this.textinputformatter
  });

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Container(
      width: 20.w,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:textTheme.bodyMedium,
          ),
          SizedBox(
            width: 12.w,
            height: 5.h,
            child: TextField(
              onSubmitted:
              (v){
                controller.text=v;
              },
              inputFormatters:textinputformatter ,
              keyboardType:keyboardType,
              controller: controller,
              decoration: InputDecoration(

                alignLabelWithHint: true,
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
