import 'package:flutter/material.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/screens/home/home_screen.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, int updatedIndex, Widget? child) { 
        return BottomNavigationBar(
          elevation: 0,
          backgroundColor: kMainTheme,
          selectedItemColor: kSecondTheme,
          unselectedItemColor: kLiteTheme,
        currentIndex: 0,
        onTap: (newIndex){
          HomeScreen.selectedIndexNotifier.value = newIndex;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: ''
          )
        ],
      );
       },
      valueListenable: HomeScreen.selectedIndexNotifier,
    );
  }
}
