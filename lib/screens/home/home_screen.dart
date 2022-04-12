import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager/main.dart';import 'package:money_manager/screens/category/category_add_popup.dart';
import 'package:money_manager/screens/category/category_screen.dart';
import 'package:money_manager/screens/stats_screen/stats_screen.dart';
import 'package:money_manager/screens/transaction/add_transactoin/add_transaction_screen.dart';
import 'package:money_manager/screens/transaction/transaction_screen.dart.dart';

import 'widgets/bottom_nav.dart';
//root screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //setting a static valuenotifier 
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  //code of pages in an array to set in to bottom nav bar 
  final _pages = const [
    TransactionScreen(),
    StatsScreen(),
    CategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainTheme,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kMainTheme,
        title: Center(
          child: Text(
            'MONEY MANGER',
            style: GoogleFonts.roboto(
                color: kLiteTheme, fontWeight: FontWeight.w800),
          ),
        ),
      ),
      //calling bottom navbar custom class 
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      //body wrapped with valuelisteneble builder
      body: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      ),
      //code to change floating action button on pressed function 
      //thru screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            //if the button press from the first screen it it will
            //redirect to [AddTransactionScreen]
           Navigator.of(context).pushNamed( AddTransactionScreen.routeName);
          } else {
            //else it will redirect to category add popup
           showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: kSecondTheme,
      ),
    );
  }
}
