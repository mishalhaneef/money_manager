import 'package:flutter/material.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/model/transaction/transaction_model.dart';
import 'package:money_manager/screens/transaction/add_transactoin/add_transaction_screen.dart';

import '../../../../main.dart';

Future<void> addTransaction({
  required BuildContext ctx,
  required selectedDate,
  required selectedCategoryModel,
  required selectedCategorytype,
}) async {
  final purposeText = purposeController.text;
  final _amountText = amountController.text;

  if (purposeText.isEmpty) {
    snackBarCall(ctx, 'Enter Purpose');
    return;
  }
  if (_amountText.isEmpty) {
    snackBarCall(ctx, 'Enter Amount');
    return;
  }
  if (selectedDate == null) {
    snackBarCall(ctx, 'Pick any Date');
    return;
  }
  final parsesAmount = double.tryParse(_amountText);
  if (parsesAmount == null) {
    return;
  }
  if (selectedCategoryModel == null) {
    snackBarCall(ctx, 'Select Any Category');
    return;
  }
  //*selected Date
  //*selected category date

  final model = TransactionModel(
    purpose: purposeText,
    amount: parsesAmount,
    date: selectedDate!,
    type: selectedCategorytype!,
    category: selectedCategoryModel!,
  );

  await TransactionDB.instance.addTransaction(model);
  purposeController.clear();
  amountController.clear();
  Navigator.of(ctx).pop();
  TransactionDB.instance.refresh();
}


ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarCall(
    ctx, text) {
  return ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: kDimMainTheme,
      content: Text(
        text,
        style: const TextStyle(color: kLiteTheme),
      ),
      action: SnackBarAction(
        label: 'Close',
        textColor: kLiteTheme,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ),
  );
}