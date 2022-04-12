import 'package:flutter/material.dart';
import 'package:money_manager/main.dart';

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    Key? key,
    required this.size,
    required this.amountController,
  }) : super(key: key);

  final Size size;
  final amountController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kLiteTheme.withAlpha(50)),
      child: TextField(
        keyboardType: TextInputType.number,
        cursorColor: kLiteTheme,
        //controller to recive the data that user typed in amount section
        controller: amountController,
        style: const TextStyle(color: kLiteTheme),
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(5),
            hintText: 'Amount',
            hintStyle: TextStyle(color: kLiteTheme)),
      ),
    );
  }
}

class PurposeTextField extends StatelessWidget {
  const PurposeTextField({
    Key? key,
    required this.size,
    required this.purposeController,
  }) : super(key: key);

  final Size size;
  final purposeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: size.width * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kLiteTheme.withAlpha(50)),
      child: TextField(
        keyboardType: TextInputType.text,
        cursorColor: kLiteTheme,
        //controller to recive the data that typed in to purpose textfield
        controller: purposeController,
        style: const TextStyle(color: kLiteTheme),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
          hintText: 'Purpose',
          hintStyle: TextStyle(color: kLiteTheme),
        ),
      ),
    );
  }
}
