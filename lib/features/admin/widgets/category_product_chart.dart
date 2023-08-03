import 'package:amazon_clone/models/sale.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryProductChart extends StatefulWidget {
  final List<Sale> sales;

  const CategoryProductChart({super.key, required this.sales});

  @override
  State<CategoryProductChart> createState() => _CategoryProductChartState();
}

class _CategoryProductChartState extends State<CategoryProductChart> {
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      charts.BarChartData(
          titlesData: charts.FlTitlesData(
              bottomTitles: charts.AxisTitles(
                  sideTitles: charts.SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              for (int i = 0; i < widget.sales.length;) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    widget.sales[value.toInt() - 1].label,
                    style: TextStyle(fontSize: 10.sp),
                  ),
                );
              }
              return const Text('');
            },
          ))),
          borderData: charts.FlBorderData(
            border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
            ),
          ),
          groupsSpace: 10,
          barGroups: [
            charts.BarChartGroupData(x: 1, barRods: [
              charts.BarChartRodData(
                  fromY: 0,
                  toY: widget.sales[0].earning.toDouble(),
                  width: 15,
                  color: Colors.amber),
            ]),
            charts.BarChartGroupData(x: 2, barRods: [
              charts.BarChartRodData(
                  fromY: 0,
                  toY: widget.sales[1].earning.toDouble(),
                  width: 15,
                  color: Colors.amber),
            ]),
            charts.BarChartGroupData(x: 3, barRods: [
              charts.BarChartRodData(
                  fromY: 0,
                  toY: widget.sales[2].earning.toDouble(),
                  width: 15,
                  color: Colors.amber),
            ]),
            charts.BarChartGroupData(x: 4, barRods: [
              charts.BarChartRodData(
                  fromY: 0,
                  toY: widget.sales[3].earning.toDouble(),
                  width: 15,
                  color: Colors.amber),
            ]),
            charts.BarChartGroupData(x: 5, barRods: [
              charts.BarChartRodData(
                  fromY: 0,
                  toY: widget.sales[4].earning.toDouble(),
                  width: 15,
                  color: Colors.amber),
            ]),
          ]),
    );
  }
}
