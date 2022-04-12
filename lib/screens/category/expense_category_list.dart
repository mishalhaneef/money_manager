import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/screens/transaction/transaction_screen.dart.dart';
import '../../model/category/category_model.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hive.openBox<CategoryModel>(databaseName);
    return ValueListenableBuilder(
      valueListenable: CategoryDb.instance.expenseCategoryListListener,
      builder: (BuildContext context, List<CategoryModel> newValue, Widget? _) {
        return Padding(
          padding:
              const EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 15),
          child: Container(
            decoration: const BoxDecoration(
                color: kDimMainTheme,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
                child: (Hive.box<CategoryModel>(databaseName).isEmpty
                    ? noData('Add Expense Category', '')
                    : ListView.separated(
                        itemBuilder: (ctx, index) {
                          final category = newValue[index];
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              ListTile(
                                leading: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                      '${index + 1}',
                                      style: const TextStyle(color: kLiteTheme),
                                    ),
                                  ],
                                ),
                                title: Text(category.name,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                subtitle: const Text('Expenses Tab',
                                    style: TextStyle(color: kLiteTheme)),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: kLiteTheme,
                                  ),
                                  onPressed: () {
                                    Widget cancel = TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: kDimMainTheme),
                                      ),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    );

                                    Widget delete = TextButton(
                                        child: const Text("Delete",
                                            style: TextStyle(
                                                color: kDimMainTheme)),
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                          CategoryDb.instance
                                              .deleteCategory(category.id);
                                        });

                                    // set up the AlertDialog
                                    AlertDialog alert = AlertDialog(
                                      backgroundColor: kLiteTheme,
                                      title: const Text("Are You Sure"),
                                      content: const Text(
                                          "This will delete you category"),
                                      actions: [delete, cancel],
                                    );

                                    // show the dialog
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: newValue.length))),
          ),
        );
      },
    );
  }
}
