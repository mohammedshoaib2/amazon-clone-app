import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_product_chart.dart';
import 'package:amazon_clone/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<Sale>? sales;
  int? totalEarnings;
  AdminServices adminServices = AdminServices();
  void getEarnings() async {
    var data = await adminServices.getEarnings(context: context);
    sales = data['sales'];
    totalEarnings = data['totalEarnings'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalEarnings == null
        ? const Loader()
        : Column(
            children: [
              // Text('\$$totalEarnings'),
              SizedBox(
                height: 100.h,
              ),
              Container(
                  height: 300,
                  margin: EdgeInsets.all(20.r),
                  child: CategoryProductChart(
                    sales: sales!,
                  )),
            ],
          );
  }
}
