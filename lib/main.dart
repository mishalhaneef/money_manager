import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/screens/transaction/add_transactoin/add_transaction_screen.dart';
import 'db/category/category_db.dart';
import 'db/transactions/transaction_db.dart';
import 'model/category/category_model.dart';
import 'model/transaction/transaction_model.dart';
import 'screens/home/home_screen.dart';

//app color themes
const kLiteTheme = Color(0xFF9196C0);
const kMainTheme = Color(0xFF292B4D);
const kDimMainTheme = Color.fromARGB(255, 32, 33, 59);
const kSecondTheme = Color.fromARGB(255, 20, 182, 194);


Future<void> main() async{
  //checking all the builds and widgets 
  //before rendering all codes and widgets
  WidgetsFlutterBinding.ensureInitialized();
  //intialising hive database
  await Hive.initFlutter();

  //checking the cateogry type adapter registered or not
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    //if not registering adapter to hive databse
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  //checking the cateogry model adapter registered or not
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    //if not registering adapter to hive databs
    Hive.registerAdapter(CategoryModelAdapter());
  }

  //checking the Transaction model adapter registered or not
  if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
    Hive.registerAdapter(TransactionModelAdapter());
  }

  //getting all the data from database before running the app 
  CategoryDb.instance.refreshUI();
  TransactionDB.instance.refresh();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'msl',
        primaryColor: const Color(0xFF292B4D),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF9196C0)),
      ),
      //seting home to [HomeScreen]
      home: const HomeScreen(),
      routes: {
        AddTransactionScreen.routeName:(ctx) => AddTransactionScreen()
      },
    );
  }
}
