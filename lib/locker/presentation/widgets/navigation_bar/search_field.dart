import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBarr extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Search",
          contentPadding: const EdgeInsets.all(5),
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          iconColor: Colors.white,
          suffixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
