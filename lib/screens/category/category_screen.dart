import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/screens/category/expense_category_list.dart';
import 'package:money_manager/screens/category/income_category_list.dart';
//root screen
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          padding: EdgeInsets.symmetric(horizontal: 20),
          controller: _tabController,
          unselectedLabelColor: kLiteTheme,
          indicator: BoxDecoration(
            color: kDimMainTheme,
            borderRadius: BorderRadius.circular(40),
          ),
          tabs: const [
             Tab(
              text: 'Income',
            ),
            Tab(
              text: 'Expenses',
            )
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeCategoryList(),
              ExpenseCategoryList(),
            ],
          ),
        )
      ],
    );
  }
}