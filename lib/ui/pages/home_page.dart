import 'package:covid19_live/ui/pages/covid_countries_page.dart';
import 'package:covid19_live/ui/pages/covid_summary_page.dart';
import 'package:covid19_live/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.darkbg,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all),
            title: Text("Summary"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text("Countries"),
          ),
        ],
        selectedIconTheme: IconThemeData(
          color: Colors.white,
        ),
        selectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
        unselectedItemColor: Colors.grey[700],
      ),
      body: IndexedStack(
        children: <Widget>[
          CovidSummaryPage(),
          CovidCountriesPage(),
        ],
        index: currentTab,
      ),
    );
  }
}
