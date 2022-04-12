import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/main.dart';
import 'package:money_manager/model/category/category_model.dart';
import 'package:money_manager/model/transaction/transaction_model.dart';
import 'package:money_manager/screens/category/category_add_popup.dart';

final purposeController = TextEditingController();
final amountController = TextEditingController();

class AddTransactionScreen extends StatefulWidget {
  static const routeName = 'add_transaction';
  AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  ValueNotifier<CategoryType> selectedCategoryNotifier1 =
      ValueNotifier(CategoryType.income);
  CategoryType? selectedCategorytype;
  CategoryModel? selectedCategoryModel;
  DateTime? selectedDate;
  String? categoryID;

  @override
  void initState() {
    selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getting all the data from databse before getting in to the screen
    CategoryDb.instance.refreshUI();
    //rebuilding income radiobutton to load data that fetched from database
    //else the radio button will not show the data because the button
    //isn't rebuild yet, the action will only load if the radio button is
    //rebuilded so we are rebuilding the button before getting the page builded!
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kMainTheme,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Text(
              'ADD TRANSACTIONS',
              style: TextStyle(
                  color: kLiteTheme, fontWeight: FontWeight.w800, fontSize: 23),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 20, left: 15, right: 15),
              child: Container(
                decoration: const BoxDecoration(
                    color: kDimMainTheme,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    const SizedBox(height: 80),

                    //textfield for recive purpose and amount
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
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
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
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
                    ),
                    const SizedBox(height: 10),

                    //date picker button code here
                    TextButton.icon(
                        onPressed: () async {
                          //storing the date picker in to the variable
                          final _selectedDateTemp = await showDatePicker(
                            context: context,
                            //setting initial date to current date
                            initialDate: DateTime.now(),
                            //the date when user firstly getting to the calender.
                            //setted in to current time that user checking
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30)),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                        primary:
                                            kDimMainTheme, // header background color
                                        onPrimary:
                                            kLiteTheme, // header text color
                                        onSurface: kMainTheme // body text color
                                        ),
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                            primary:
                                                kDimMainTheme // button text color
                                            ))),
                                child: child!,
                              );
                            },
                          );

                          //cheking null
                          if (_selectedDateTemp == null) {
                            return;
                          } else {
                            //*sending selected date to another varable, and that variable
                            //*will show in date picekr text
                            setState(() {
                              selectedDate = _selectedDateTemp;
                            });
                          }
                        },
                        icon: Icon(Icons.calendar_today,
                            color: kLiteTheme.withAlpha(160)),
                        label: Text(
                            selectedDate == null
                                ? 'PICK DATE'
                                : selectedDate!.day.toString(),
                            style:
                                TextStyle(color: kLiteTheme.withAlpha(160)))),
                    const SizedBox(height: 4),
                    //both radio button code here in this widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: CategoryType.income,
                              groupValue: selectedCategorytype,
                              onChanged: (value) {
                                setState(() {
                                  categoryID = null;
                                  CategoryDb.instance.refreshUI();
                                  selectedCategorytype = CategoryType.income;
                                });
                              },
                              //style of radio button
                              activeColor: kLiteTheme,
                              hoverColor: kLiteTheme,
                              overlayColor: MaterialStateProperty.all<Color>(
                                  kSecondTheme),
                              fillColor:
                                  MaterialStateProperty.all<Color>(kLiteTheme),
                            ),
                            const Text(
                              'Income',
                              style: TextStyle(
                                  color: kLiteTheme,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: CategoryType.expense,
                                groupValue: selectedCategorytype,
                                onChanged: (value) {
                                  setState(() {
                                    categoryID = null;
                                    CategoryDb.instance.refreshUI();
                                    selectedCategorytype =
                                        CategoryType.expense;
                                  });
                                },
                                //styles of radio button
                                activeColor: kLiteTheme,
                                hoverColor: kLiteTheme,
                                overlayColor: MaterialStateProperty.all<Color>(
                                    kSecondTheme),
                                fillColor: MaterialStateProperty.all<Color>(
                                    kLiteTheme)),
                            const Text('Expenses',
                                style: TextStyle(
                                    color: kLiteTheme,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                    //category type slector thru dorp down,
                    //down below is the dropdown widget dropdown
                    GestureDetector(
                      onTap: () => ifelse(context),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        
                          color: kLiteTheme.withAlpha(50),
                        ),
                        child: Center(
                            child: DropdownButton<String>(
                          style: const TextStyle(color: kLiteTheme),
                          dropdownColor: kMainTheme,
                          iconEnabledColor: kLiteTheme,
                          underline: const SizedBox(),
                          elevation: 0,
                          hint: const Text('Select category  ',
                              style: TextStyle(color: kLiteTheme)),
                          value: categoryID,
                          items: (selectedCategorytype == CategoryType.income
                                  ? CategoryDb().incomeCategoryListListener
                                  : CategoryDb().expenseCategoryListListener)
                              .value
                              .map((e) {
                            return DropdownMenuItem(
                              onTap: () {
                                selectedCategoryModel = e;
                              },
                              value: e.id,
                              child: Text(e.name,
                                  style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (String? selectedValue) {
                            print(selectedValue);
                            setState(() {
                              categoryID = selectedValue;
                            });
                          },
                        )),
                      ),
                    ),
                    ifelse(context),
                    // ifelse(context),
                    // (
                    //   Hive.box<CategoryModel>(databaseName).isEmpty
                    //   ? TextButton(onPressed: (){
                    //   showCategoryAddPopup(context);
                    // }, child: const Text('Create new Category',
                    // style: TextStyle(color: kSecondTheme, fontSize: 13),
                    // ))
                    //  : SizedBox()
                    //  ),

                    // (
                    //   if(Hive.box<CategoryModel>(databaseName).isEmpty){
                    //       TextButton(onPressed: (){
                    //   showCategoryAddPopup(context);
                    // }, child: const Text('Create new Category',
                    // style: TextStyle(color: kSecondTheme, fontSize: 13),
                    // ))
                    //   },
                    //   else{

                    //   }
                    // )

                    //add button to add all transaction given
                    //data to home screen/transaction screen
                    ElevatedButton(
                      //on pressed
                      onPressed: () async {
                        addTransaction(context);
                        TransactionDB.instance.getAllTransactions();
                      },
                      //text to shoe in to the button
                      child: const Text('Add',
                          style: TextStyle(color: kMainTheme)),
                      //style section code here
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide())),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kLiteTheme),
                      ),
                    ),
                    const SizedBox(height: 70)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction(BuildContext ctx) async {
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

  Future<void> getTransaction() async {}
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

Widget ifelse(BuildContext context) {
  if (Hive.box<CategoryModel>(databaseName).isEmpty) {
    return TextButton(onPressed: (){
                      showCategoryAddPopup(context);
                    }, child: const Text('Create new Category',
                    style: TextStyle(color: kSecondTheme, fontSize: 13),
                    ));
  } else {
    return SizedBox();
  }
}


// TextButton(
//           onPressed: () {
//             showCategoryAddPopup(context);
//           },
//           child: const Text(
//             'Create new Category',
//             style: TextStyle(color: kSecondTheme, fontSize: 13),
//           )),