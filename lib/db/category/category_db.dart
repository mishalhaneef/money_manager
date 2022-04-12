import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/model/category/category_model.dart';

const databaseName = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  // ignore: non_constant_identifier_names
  Future<void> deleteCategory(CategoryID);
}


//CRUD operations code

//making singletone
class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    
    return instance;
  }

  //code for both income and expens notifier, if any vaue has changed this will rebuild
  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      //the value initially null
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    //opening hive database and getting in to a variable [_categoryDB]
    final _categoryDB = await Hive.openBox<CategoryModel>(databaseName);
    //putting id and transction model in to the database thru object
    await _categoryDB.put(value.id, value);
    //refreshing the ui after adding, else the data will be added but the screen will not be change
    refreshUI();
  }

  //function to get all the data from database
  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(databaseName);
    return _categoryDB.values.toList();
  }

  //this code will refresh the ui and also get all data from database,
  //if any data has operating on CRUD, then this funciton should be called
  Future<void> refreshUI() async {
    //callling funciton [getCategories]
    final _allCategories = await getCategories();
    //clearing value from notifier to avoid duplications
    //How the data will duplicated if this line of code removed :
    //[ the data also storing in to notifier so nootifier's data and also db's data
    //will display on this screen, so thats why clearing the data in the notifer first]
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    //adding data using for loop (foreach), if the category type is income
    //then the data will notify the incom notifer, else it will notify the expens notifier
    //-
    //this variable has included the all data from the from database, [code line 48]
    await Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );
    //notifiying all the listeners
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  //removing the category data form the database,
  @override
  Future<void> deleteCategory(cateogryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(databaseName);
    await _categoryDB.delete(cateogryID);
    refreshUI();
  }
}
