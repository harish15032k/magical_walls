import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Earnings/screens/withdraw.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/earnings_controller.dart';
import '../model/earnings_model.dart' show Datum;

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  final EarningsController controller = Get.put(EarningsController());

  @override
  void initState() {
    super.initState();
    _loadInitialData();

  }


  void _loadInitialData() {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    final end = start.add(const Duration(days: 6));
    controller.getEarnings(start.toIso8601String(), end.toIso8601String());
  }

  void _navigateWeek(bool isNext) {
    final week = controller.currentWeek.value;
    final now = DateTime.now();

    DateTime newStart = week.start.add(Duration(days: isNext ? 7 : -7));
    if (newStart.month == now.month) {
      DateTime newEnd = newStart.add(const Duration(days: 6));
      controller.getEarnings(newStart.toIso8601String(), newEnd.toIso8601String());


      controller.currentWeek.value = (start: newStart, end: newEnd);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Earnings", style: CommonTextStyles.medium20),
                  Image.asset(
                    "assets/images/calendar.png",
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/blue.png'),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Earnings",
                          style: CommonTextStyles.regular14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "₹12,450",
                          style: CommonTextStyles.medium24.copyWith(
                            color: CommonColors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CommonButton(
                          borderRadius: 3,
                          width: 90,
                          height: 30,
                          text: "Withdraw",
                          backgroundColor: Colors.white,
                          textColor: Colors.deepPurple,
                          borderColor: Colors.white,
                          onTap: () {
                            Get.to(() => WithdrawScreen());
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/coin.png',
                          width: 55,
                          height: 55,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Completed Jobs", style: CommonTextStyles.regular14),
                      const SizedBox(height: 4),
                      Text("52", style: CommonTextStyles.medium16),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Pending Payments",
                        style: CommonTextStyles.regular14,
                      ),
                      const SizedBox(height: 4),
                      Text("₹1,200", style: CommonTextStyles.medium16),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text("Earning Analytics", style: CommonTextStyles.medium22),
              const SizedBox(height: 16),
              Container(
                height: 300,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.black54,
                          ),
                          onPressed: () => _navigateWeek(false),
                        ),
                        Obx(() => Column(
                          children: [
                            Text(
                              "${DateFormat('MMM d').format(controller.currentWeek.value.start)} "
                                  "- ${DateFormat('d').format(controller.currentWeek.value.end)}",
                            ),
                            Text("₹${controller.totalEarnings.value}", style: CommonTextStyles.medium16),
                          ],
                        )),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black54,
                          ),
                          onPressed: () => _navigateWeek(true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Obx(() => BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: controller.earningsData.isNotEmpty
                              ? (controller.earningsData.map((e) => e.amount ?? 0).reduce((a, b) => a > b ? a : b) * 1.1).toDouble()
                              : 100,

                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                                  return Text(
                                    value.toInt() < days.length ? days[value.toInt()] : '',
                                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),


                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          barGroups: controller.earningsData.asMap().entries.map((entry) {
                            int index = entry.key;
                            Datum data = entry.value;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: (data.amount ?? 0).toDouble(),
                                  color: Colors.deepPurple,
                                  width: 20,
                                  borderRadius: BorderRadius.circular(2),
                                  backDrawRodData: BackgroundBarChartRodData(show: false),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      )),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Earnings Breakdown List",
                    style: CommonTextStyles.medium22,
                  ),
                  Text(
                    "View All",
                    style: CommonTextStyles.regular16.copyWith(
                      color: CommonColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CommonColors.textFieldGrey),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        color: CommonColors.textFieldGrey.withAlpha(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service",
                              style: CommonTextStyles.regular16.copyWith(
                                color: CommonColors.black,
                              ),
                            ),
                            Text(
                              "Earning",
                              style: CommonTextStyles.regular16.copyWith(
                                color: CommonColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildEarningsItem(
                        "AC Gas Refill",
                        "17 July, 10:00 AM",
                        "₹899",
                        true,
                      ),
                      Divider(),
                      _buildEarningsItem(
                        "AC Gas Refill",
                        "17 July, 10:00 AM",
                        "₹899",
                        true,
                      ),
                      Divider(),
                      _buildEarningsItem(
                        "AC Gas Refill",
                        "17 July, 10:00 AM",
                        "₹899",
                        true,
                      ),
                      Divider(),
                      _buildEarningsItem(
                        "AC Gas Refill",
                        "17 July, 10:00 AM",
                        "₹899",
                        true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsItem(
      String service,
      String date,
      String earning,
      bool isPaid,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(service, style: CommonTextStyles.regular16),
              const SizedBox(height: 2),
              Text(
                date,
                style: CommonTextStyles.regular14.copyWith(color: CommonColors.secondary),
              ),
            ],
          ),
          Column(
            children: [
              Text(earning, style: CommonTextStyles.medium14),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CommonColors.green.withAlpha(25),
                ),
                child: Text(
                  isPaid ? "Paid" : "Pending",
                  style: CommonTextStyles.regular12.copyWith(
                    color: isPaid ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}