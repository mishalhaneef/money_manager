import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/model/category/category_model.dart';
import 'package:money_manager/model/transaction/transaction_model.dart';

ListView transactionPage(List<TransactionModel> newlist) {
  return ListView.separated(
    padding: const EdgeInsets.all(2),
    itemBuilder: (ctx, index) {
      final valueOBJ = newlist[index];
      return Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 18, left: 18),
            //slidable class to slide to delete, using a package
            child: Slidable(
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      //on pressed the value will be deleted
                      TransactionDB.instance.deleteTransactionList(valueOBJ.id);
                    },
                    icon: Icons.delete,
                    backgroundColor: kDimMainTheme,
                  ),
                  SlidableAction(
                    //on pressed default thing will hapen
                    //default: will close the slidable action
                    onPressed: (ctx) {},
                    icon: Icons.undo,
                    backgroundColor: kDimMainTheme,
                  ),
                ],
              ),
              key: Key(valueOBJ.id!),
              child: Card(
                elevation: 0,
                color: kDimMainTheme,
                child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.only(
                          right: 2, left: 2, top: 0.1, bottom: 0.1),
                      decoration: const BoxDecoration(
                          color: kLiteTheme,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: kLiteTheme,
                        child: Text(
                          parseDate(valueOBJ.date),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    title: (valueOBJ.type == CategoryType.income
                        ? Text('${valueOBJ.amount} ₹',
                            style: const TextStyle(color: Colors.green))
                        : Text('${valueOBJ.amount} ₹',
                            style: const TextStyle(color: Colors.red))),

                    //name put as subtitle
                    subtitle: Text(valueOBJ.category.name,
                        style:
                            const TextStyle(color: kLiteTheme, fontSize: 14)),
                    //set the arrow icons as trailing, if its incom then green up
                    //else red down
                    trailing: Text(
                      valueOBJ.purpose,
                      style: const TextStyle(color: kLiteTheme),
                    )),
              ),
            ),
          ),
        ],
      );
    },
    separatorBuilder: (ctx, index) {
      return const SizedBox(height: 10);
    },
    //the list will expand depends on the newlist's length,
    //and the newlist will create how many user creating
    itemCount: newlist.length,
  );
}

//parsing date to day and month only to show to the display
String parseDate(DateTime date) {
  final _date = DateFormat.MMMd().format(date);
  final _splitedDate = _date.split(' ');
  return '${_splitedDate.first}\n${_splitedDate.last}';
  // return '${date.day} | ${date.month}';
}
