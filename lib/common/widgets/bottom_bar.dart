import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  void updatePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = const [
    HomeScreen(),
    AccountScreen(),
    CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        // showUnselectedLabels: false,
        // showSelectedLabels: false,
        currentIndex: selectedIndex,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42.w,
              height: 35.h,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 4.h,
                color: selectedIndex == 0
                    ? GlobalVariables.selectedNavBarColor
                    : Colors.transparent,
              ))),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: 42.w,
              height: 35.h,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 4.h,
                          color: selectedIndex == 1
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent))),
              child: const Icon(
                Icons.person_3_outlined,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              alignment: Alignment.bottomCenter,
              width: 42.w,
              height: 35.h,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border(
                      top: BorderSide(
                width: 4.h,
                color: selectedIndex == 2
                    ? GlobalVariables.selectedNavBarColor
                    : Colors.transparent,
              ))),
              child: badges.Badge(
                badgeContent: Text(
                    '${Provider.of<UserProvider>(context).user.cart.length}'),
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.white),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
