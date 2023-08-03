import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        itemExtent: 90.h,
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          Map map = GlobalVariables.categoryImages[index];

          String images = map['image'];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) {
                    return CategoryDealsScreen(category: map['title']);
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      images,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(map['title']),
            ],
          );
        },
      ),
    );
  }
}
