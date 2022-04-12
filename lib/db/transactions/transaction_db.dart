import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/transaction/transaction_model.dart';

// ignore: constant_identifier_names
const transactionDB_name = 'transaction-db';

//abstract class that include function for CRUD operations
abstract class TransactionDbFunction {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransactionList(transactionID);
}


class TransactionDB implements TransactionDbFunction {
  
  /// setting the [TransactionDB] class Singleton
  /// The singleton pattern is a pattern used in object-oriented programming 
  /// which ensures that a class has only one instance and also provides 
  /// a global point of access to it. ... Thanks to factory constructors, 
  /// implementing the singleton pattern in Dart is not only possible, 
  /// but simple and flexible.
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
     log('mesaasage');
    /// now we have to call all these function as instance 
    /// or its all work as deferend funciton and classes
    /// example [TransactionDB.instance.deleteTransaction]
    return instance;
  }

  //code of a value notifier object, and the value notifier is list of transaction model
  ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);

  //function to add transaction
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    //opening hive database and getting in to a variable [_db]
    final _db = await Hive.openBox<TransactionModel>(transactionDB_name);
    //putting id and transction model in to the database thru object 
    _db.put(obj.id, obj);
  }

  TransactionModel? _value;
  ValueNotifier<TransactionModel> transactionmodelAmount = ValueNotifier(TransactionDB.instance._value!);

  //funciton to refresh the UI
  Future<void> refresh() async {
    log('message');
    //when refresh getting all the transaction detail from database 
    final _list = await getAllTransactions();
   
    //and sorting date for displaying the  value for display transaction as data based
    _list.sort((first, second) => second.date.compareTo(first.date));
    //clearing value from notifier, or else the data will be duplicate, cos it will show the data from db 
    //and also from the notifier so we've to clear the value on notifier
    transactionNotifier.value.clear();
    //and adding the value to notifier to get notify the value for rebeuild the display from screen code
    transactionNotifier.value.addAll(_list);
    //and notifiy them all
    transactionNotifier.notifyListeners();
  }

  //getting all the transaction from database
  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    //opening db
    final _db = await Hive.openBox<TransactionModel>(transactionDB_name);
    //returning the values from the db as list
    return _db.values.toList();
  }

  //function to delete the transaction
  @override
  Future<void> deleteTransactionList(transactionID) async{
    //opening database
    final transactionDB = await Hive.openBox<TransactionModel>(transactionDB_name);
    //deleting based on id 
    await transactionDB.delete(transactionID);
    //after deleting , here is the code to refresh to refesh the screen, else
    //it will not be removed from display
    TransactionDB.instance.refresh();
  }
}
