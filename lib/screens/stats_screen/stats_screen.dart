import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/model/transaction/transaction_model.dart';
import 'package:money_manager/screens/transaction/add_transactoin/add_transaction_screen.dart';
import 'package:pie_chart/pie_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final values = TransactionDB.instance.transactionNotifier.value;
    final amount = values[0].amount;
    TransactionDB.instance.refresh();
    TransactionModel? obj;
    var data;
    // for (var amount in values) {
    //   Map<String, double> dataMap = {"Income": amount.amount, "Expense": 1000};
    // }
    ValueNotifier<TransactionModel> totalNotifier = ValueNotifier(data);

    Map<String, double> dataMap = {"Income": amount + 1000, "Expense": amount};
    for (var amount in values) {
      Map<String, double> dataMap = {"Income": amount.amount, "Expense": 1000};
    }

    return Scaffold(
        backgroundColor: kMainTheme,
        body: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionNotifier,
              builder: (BuildContext context, List<TransactionModel> value,
                  Widget? _) {
                    data = value;
                // ignore: avoid_function_literals_in_foreach_calls
                return Row(
                  children: [
                    const SizedBox(width: 30),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 50),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kDimMainTheme),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text('Income',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(height: 10),
                            Text('23400 ₹',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                    const SizedBox(width: 30),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 50),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kDimMainTheme,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            const Text('Expense',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const SizedBox(height: 10),
                            Text(totalNotifier.value.amount.toString(),
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      Navigator.of(context)
                          .pushNamed(AddTransactionScreen.routeName);
                    },
                    icon: Icons.add_box,
                    foregroundColor: kLiteTheme,
                    backgroundColor: kDimMainTheme,
                  ),
                ],
              ),
              child: PieChart(
                colorList: const [
                  Color(0xFF177E89),
                  Color(0xFFDB3A34),
                ],
                emptyColor: Colors.white,
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                chartValuesOptions: const ChartValuesOptions(
                  chartValueStyle: TextStyle(color: Colors.white),
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ),
            ),
          ],
        ));
  }
  final parsesAmount = double.tryParse(amountController.text);
  
  final model = TransactionModel(
      purpose: purposeController.text,
      amount: parsesAmount!,
      date: selectedDate!,
      type: selectedCategorytype!,
      category: selectedCategoryModel!,
    );
}
