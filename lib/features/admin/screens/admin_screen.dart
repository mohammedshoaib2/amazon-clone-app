import 'package:amazon_clone/features/admin/screens/analytics_screen.dart';
import 'package:amazon_clone/features/admin/screens/orders_screen.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selectedIndex = 0;
  void updatePage(int val) {
    setState(() {
      selectedIndex = val;
    });
  }

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  height: 120.h,
                  width: 100.w,
                  color: Colors.black,
                ),
              ),
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
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
                Icons.analytics_outlined,
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
                          color: selectedIndex == 2
                              ? GlobalVariables.selectedNavBarColor
                              : Colors.transparent))),
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
