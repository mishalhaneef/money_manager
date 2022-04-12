import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/model/category/category_model.dart';
import '../../../../main.dart';

class RadioButtonWidget extends StatefulWidget {
  RadioButtonWidget({
    Key? key,
    required this.selectedCategorytype,
    required this.categoryID,
  }) : super(key: key);
  var selectedCategorytype;
  var categoryID;
  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio(
              value: CategoryType.income,
              groupValue: widget.selectedCategorytype,
              onChanged: (value) {
                setState(() {
                  widget.categoryID = null;
                  CategoryDb.instance.refreshUI();
                  widget.selectedCategorytype = CategoryType.income;
                });
              },
              //style of radio button
              activeColor: kLiteTheme,
              hoverColor: kLiteTheme,
              overlayColor: MaterialStateProperty.all<Color>(kSecondTheme),
              fillColor: MaterialStateProperty.all<Color>(kLiteTheme),
            ),
            const Text(
              'Income',
              style: TextStyle(color: kLiteTheme, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          children: [
            Radio(
                value: CategoryType.expense,
                groupValue: widget.selectedCategorytype,
                onChanged: (value) {
                  setState(() {
                    widget.categoryID = null;
                    CategoryDb.instance.refreshUI();
                    widget.selectedCategorytype = CategoryType.expense;
                  });
                },
                //styles of radio button
                activeColor: kLiteTheme,
                hoverColor: kLiteTheme,
                overlayColor: MaterialStateProperty.all<Color>(kSecondTheme),
                fillColor: MaterialStateProperty.all<Color>(kLiteTheme)),
            const Text('Expenses',
                style:
                    TextStyle(color: kLiteTheme, fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }
}
