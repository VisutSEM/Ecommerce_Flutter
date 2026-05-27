import 'package:e_commerce_flutter/app/modules/home/views/home_view.dart';
import 'package:e_commerce_flutter/app/modules/product/views/product_view.dart';
import 'package:e_commerce_flutter/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import '../../cart/views/cart_view.dart';
import '../widget/floating_navbar.dart';


class MainAppView extends StatefulWidget {
  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainAppView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeView(),
    ProductView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
