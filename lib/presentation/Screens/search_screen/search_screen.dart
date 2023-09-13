



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';

class ScreenSearch extends StatelessWidget {
  
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColorgrey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Search',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height/5.9,
        width: double.infinity,
        color:backgroundColorWhite,
        child: Expanded(
          child: TextField(
             textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Category",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: hintTextColor,
                              fontWeight: FontWeight.w500),
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: textColor,
                          ),
                        ),
          ),
        ),
      ),
    );
  }
}