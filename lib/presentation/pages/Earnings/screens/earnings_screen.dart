import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:magical_walls/core/constants/app_text.dart';
import 'package:magical_walls/presentation/pages/Earnings/screens/withdraw.dart';
import 'package:magical_walls/presentation/widgets/common_button.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
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

                            Get.to(()=> WithdrawScreen());
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
                        Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                          color: Colors.black54,
                        ),
                        Column(
                          children: [
                            Text(
                              "July 21 - 27",
                              style: CommonTextStyles.regular14,
                            ),
                            Text("₹2,860", style: CommonTextStyles.medium16),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),


                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(7, (index) {
                          final heights = [
                            120.0,
                            150.0,
                            140.0,
                            200.0,
                            160.0,
                            80.0,
                            130.0,
                          ];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: heights[index],
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text("SMTWTFS"[index]),
                            ],
                          );
                        }),
                      ),
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
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.fromLTRB(8,4,8,4),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: CommonColors.green.withAlpha(25)),
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
