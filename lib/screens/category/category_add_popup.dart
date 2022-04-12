import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/model/category/category_model.dart';
//*comment in this color is mentioning the radio  button

//creates a class for value notifier
ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  //creating a dialog box , the popup screen code 
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        backgroundColor: kMainTheme,
        // backgroundColor: mainTheme,
        title: const Text('Add Category', style: TextStyle(color: kLiteTheme)),
        children: [
          //code of textfield
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _nameEditingController,
              textAlign: TextAlign.center,
              style: const TextStyle(color: kLiteTheme),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: kSecondTheme, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: kLiteTheme, width: 2)),
                contentPadding: const EdgeInsets.all(5),
                hintText: 'Category',
                hintStyle: const TextStyle(color: kLiteTheme),
              ),
            ),
          ),
          //code for radio buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                SizedBox(width: 16),
                RadioButton(title: 'Income', type: CategoryType.income),
                SizedBox(width: 16),
                RadioButton(title: 'Expenses', type: CategoryType.expense),
              ],
            ),
          ),
          //code of add button
          Padding(
            padding: const EdgeInsets.only(right: 68, left: 68),
            child: ElevatedButton(
              //on pressed
              onPressed: () async {
                final _categoryName = _nameEditingController.text;
                if (_categoryName.isEmpty) {
                  return;
                }

                final _type = selectedCategoryNotifier.value;
                //sending the data to model class
                final _category = CategoryModel(
                  name: _categoryName,
                  type: _type,
                );
                //inserting the data to database
                CategoryDb.instance.insertCategory(_category);
                //refreshing the ui
                CategoryDb.instance.refreshUI();
                //and quitting the popup screen
                Navigator.of(ctx).pop();
              },
              //text to shoe in to the button
              child: const Text('Add', style: TextStyle(color: kMainTheme)),
              //style section code here
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: kLiteTheme))),
                backgroundColor: MaterialStateProperty.all<Color>(kSecondTheme),
              ),
            ),
          ),
        ],
      );
    },
  );
}

//widgets of radio button
class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              //radio button codes here
              return Radio<CategoryType>(
                overlayColor: MaterialStateProperty.all<Color>(kSecondTheme),
                fillColor: MaterialStateProperty.all<Color>(kLiteTheme),
                value: type,
                groupValue: newCategory,
                //* passing categoryType's single value that user selected thru the object calles value down below
                onChanged: (CategoryType? value) {
                  //* checking is the value is null or not
                  if (value == null) {
                    //* if null return to nowere, it will store to a
                    //* register, means: in on changed we are declaring a anonymouse function,
                    //* so the value will return to that function, and we never gonna call or we cant
                    //* call the anony funciton no where, so the value wil waste in air XD.
                    return;
                  }
                  //*and setting the value to [selectedCategoryNotifier]'s values.
                  //*and when it happened the whole radio button will be rebuild
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        //text for radio button
        Text(title, style: const TextStyle(color: kLiteTheme))
      ],
    );
  }
}
