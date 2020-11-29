import 'package:amr_apps/ui/shared/color.dart';
import 'package:amr_apps/ui/history_screen.dart';
import 'package:amr_apps/ui/home_screen.dart';
import 'package:amr_apps/ui/profile_screen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  TabController _tabController;

  List<TabData> tabItems = List.of([
    TabData(iconData: Icons.home, title: "Home"),
    TabData(iconData: Icons.list, title: "History"),
    TabData(iconData: Icons.account_circle, title: "Profile"),
  ]);

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: tabItems.length, initialIndex: 0);
    _tabController.addListener(() {
      FancyBottomNavigationState fstate = bottomNavigationKey.currentState;
      fstate.setPage(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: primaryColor1,
        activeIconColor: colorWhite,
        textColor: colorWhite,
        circleColor: primaryColor2,
        inactiveIconColor: colorWhite,
        initialSelection: 0,
        tabs: tabItems,
        key: bottomNavigationKey,
        onTabChangedListener: (int selectedPos) {
          _tabController.index = selectedPos;
        },
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to exit'),
        ),
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            HomeScreen(),
            HistoryScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
