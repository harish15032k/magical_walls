import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Earnings/screens/withdraw.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

import '../controller/earnings_controller.dart';
import '../model/Monthly_model.dart';

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
    controller.getMonthlyEarnings("weekly");
  }

  void _onCalendarFilterSelected(String filter) {
    controller.getMonthlyEarnings(filter.toLowerCase());
  }

  void _navigateWeek(bool isNext) {
    final week = controller.currentWeek.value;
    final now = DateTime.now();

    DateTime newStart = week.start.add(Duration(days: isNext ? 7 : -7));
    if (newStart.month == now.month) {
      DateTime newEnd = newStart.add(const Duration(days: 6));
      controller.getEarnings(
        newStart.toIso8601String(),
        newEnd.toIso8601String(),
      );

      controller.currentWeek.value = (start: newStart, end: newEnd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Earnings", style: CommonTextStyles.medium20),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.calendar_month, size: 22),
                    onSelected: _onCalendarFilterSelected,
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "Weekly",
                        child: Text("Weekly"),
                      ),
                      const PopupMenuItem(
                        value: "Monthly",
                        child: Text("Monthly"),
                      ),
                      const PopupMenuItem(
                        value: "Yearly",
                        child: Text("Yearly"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Obx(() {
                final total = controller.monthlyEarningsData.fold<double>(
                  0,
                  (sum, item) => sum + double.tryParse(item.price ?? "0")!,
                );

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(children: [
                    Positioned.fill(child: Image.asset('assets/images/blue.png',
                      fit: BoxFit.fill,)),
                    Padding(padding: const EdgeInsets.only(
                        top: 8, left: 12, right: 22, bottom: 10), child: Row(
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
                            const SizedBox(height: 4),
                            Text(
                              "₹${total.toStringAsFixed(0)}",
                              style: CommonTextStyles.medium24.copyWith(
                                color: Colors.white,fontSize: 20
                              ),
                            ),
                            const SizedBox(height: 10),
                            CommonButton(
                              borderRadius: 3,
                              width: 100,
                              height: 30,
                              text: "Withdraw",
                              backgroundColor: Colors.white,
                              textColor: Colors.deepPurple,
                              borderColor: Colors.white,
                              onTap: () {
                                Get.to(() =>
                                    WithdrawScreen(
                                      totalEarnings: total.toStringAsFixed(
                                          0),));
                              },
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/coin.png',
                          width: 55,
                          height: 55,
                        ),
                      ],
                    ),),
                  ],
                  )
                  ,
                );
              }),
              const SizedBox(height: 20),
              Obx((){
                final completedJobs = controller.data.value.completedCount??0;
                final pending = controller.data.value.totalPendingAmount;
             return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Completed Jobs", style: CommonTextStyles.regular14),
                        const SizedBox(height: 4),
                        Text(completedJobs.toString(), style: CommonTextStyles.medium16),
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
                        Text(pending.toString(), style: CommonTextStyles.medium16),
                      ],
                    ),
                  ],
                );}
              ),
              const SizedBox(height: 10),
              //
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
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.black54,
                          ),
                          onPressed: () => _navigateWeek(false),
                        ),
                        Obx(
                          () => Column(
                            children: [
                              Text(
                                "${DateFormat('MMM d').format(controller.currentWeek.value.start)}"
                                " - ${DateFormat('d').format(controller.currentWeek.value.end)}",
                              ),
                              Text(
                                "₹${controller.totalEarnings.value}",
                                style: CommonTextStyles.medium16,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
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
                      child: Obx(
                        () => BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: controller.earningsData.isNotEmpty
                                ? (controller.earningsData
                                              .map((e) => e.amount ?? 0)
                                              .reduce((a, b) => a > b ? a : b) *
                                          1.1)
                                      .toDouble()
                                : 100,
                            barTouchData: BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final days = [
                                      'S',
                                      'M',
                                      'T',
                                      'W',
                                      'T',
                                      'F',
                                      'S',
                                    ];
                                    return Text(
                                      value.toInt() < days.length
                                          ? days[value.toInt()]
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
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
                            barGroups: controller.earningsData
                                .asMap()
                                .entries
                                .map((entry) {
                                  int index = entry.key;
                                  final data = entry.value;
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: (data.amount ?? 0).toDouble(),
                                        color: Colors.deepPurple,
                                        width: 20,
                                        borderRadius: BorderRadius.circular(2),
                                        backDrawRodData:
                                            BackgroundBarChartRodData(
                                              show: false,
                                            ),
                                      ),
                                    ],
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Earnings Breakdown", style: CommonTextStyles.medium22),
                  Obx(() {
                    final listLength = controller.monthlyEarningsData.length;
                    if (listLength >5) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => EarningsFullListScreen(
                              earningsList: controller.monthlyEarningsData,
                            ),
                          );
                        },
                        child: Text(
                          "View All",
                          style: CommonTextStyles.regular16.copyWith(
                            color: CommonColors.primaryColor,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
              const SizedBox(height: 8),
              Obx(() {
                final list = controller.monthlyEarningsData.length > 5
                    ? controller.monthlyEarningsData.take(5).toList()
                    : controller.monthlyEarningsData;

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CommonColors.textFieldGrey),
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length + 1,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: const EdgeInsets.all(12),
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
                        );
                      }
                      final item = list[index - 1];
                      return _buildEarningsItem(item);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsItem(CompletedServicesPaid item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.service?.name ?? "-",
                style: CommonTextStyles.regular16,
              ),
              const SizedBox(height: 2),
              Text(
                item.paidAt != null
                    ? DateFormat(
                        'd MMM, hh:mm a',
                      ).format(DateTime.parse(item.paidAt.toString()))
                    : "-",
                style: CommonTextStyles.regular14.copyWith(
                  color: CommonColors.secondary,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text("₹${item.price}", style: CommonTextStyles.medium14),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: item.paidStatus == "paid"
                      ? CommonColors.green.withAlpha(25)
                      : Colors.orange.withAlpha(25),
                ),
                child: Text(
                  item.paidStatus == "paid" ? "Paid" : "Pending",
                  style: CommonTextStyles.regular12.copyWith(
                    color: item.paidStatus == "paid"
                        ? Colors.green
                        : Colors.orange,
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


class EarningsFullListScreen extends StatelessWidget {
  final List<CompletedServicesPaid> earningsList;

  const EarningsFullListScreen({
    super.key,
    required this.earningsList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      'assets/images/arrow-left.png',
                      width: 25,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "All Earnings",
                    style: CommonTextStyles.medium20,
                  ),
                ],
              ),
              const SizedBox(height: 16),


              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: CommonColors.textFieldGrey),
                  borderRadius: BorderRadius.circular(10),
                  color: CommonColors.textFieldGrey.withAlpha(100),
                ),
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
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: earningsList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = earningsList[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(color: CommonColors.textFieldGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.service?.name ?? "-",
                                style: CommonTextStyles.regular16,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.paidAt != null
                                    ? DateFormat('d MMM, hh:mm a').format(
                                    DateTime.parse(item.paidAt.toString()))
                                    : "-",
                                style: CommonTextStyles.regular14.copyWith(
                                  color: CommonColors.secondary,
                                ),
                              ),
                            ],
                          ),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹${item.price}",
                                style: CommonTextStyles.medium14,
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: item.paidStatus == 'paid'
                                      ? Colors.green.withAlpha(40)
                                      : Colors.red.withAlpha(40),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.paidStatus == 'paid'
                                      ? "Paid"
                                      : "Pending",
                                  style: CommonTextStyles.regular14.copyWith(
                                    color: item.paidStatus == 'paid'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



