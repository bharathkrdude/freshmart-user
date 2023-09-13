import 'package:flutter/material.dart';

import 'package:fresh_mart/Presentation/screens/main_screen/widgets/bottom_nav.dart';


class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      
      
      
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}