import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../Earnings/screens/earnings_screen.dart';
import '../../profile/screens/profile_screen.dart';
import 'home_screen.dart';

class BottomBar extends StatefulWidget {

  final int initialIndex;
  final int tabIndex;

  const BottomBar({super.key,  this.initialIndex = 0, this.tabIndex=0});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  List<Widget> get _widgetOptions => [
    HomeScreen(initialindex:widget.tabIndex ,),
    EarningsScreen(),
    ProfileScreen(),

    // EarningsScreen(role: widget.role),
    // ProfileScreen(role: widget.role),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavBarItem(String assetPath, int index) {
    return BottomNavigationBarItem(
      backgroundColor: CommonColors.white,
      icon: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? CommonColors.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight:Radius.circular(8) ),
            ),
            height: 4,
            width: 55,
          ),
          SizedBox(height: 10),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              _selectedIndex == index
                  ? CommonColors.primaryColor
                  : CommonColors.grey,
              BlendMode.srcIn,
            ),
            child: Image.asset(assetPath, width: 24, height: 24),
          ),
        ],
      ),
      label: _getNavBarLabel(index,),
    );
  }

  String _getNavBarLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Earnings';
      case 2:
        return 'Profile';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.white,
      child: SafeArea(
        child: Scaffold(
          body: _widgetOptions[_selectedIndex],
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromARGB(133, 240, 240, 240),
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.70),
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: CommonColors.white,
              items: [
                _buildNavBarItem('assets/images/home.png', 0),
                _buildNavBarItem('assets/images/earnings.png', 1),
                _buildNavBarItem('assets/images/profile.png', 2),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: CommonColors.primaryColor,
              unselectedItemColor: CommonColors.grey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}
