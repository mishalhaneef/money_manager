import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 0)
// creating an enum for income and expense section to use when need a use 
// of values income and category
// what is enum?
// The enum keyword is used to define an enumeration type in Dart. ... 
// The enum is the keyword used to initialize enumerated data type. 
// The variable_name as the name suggests is used for naming the enumerated class. 
// The data members inside the enumerated class must be separated by the commas.
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}


@HiveType(typeId: 1)
//in this [CategoryModel] coded some values that we needed to show in display ,
//id for storing data in to database, and we are sending the id to database 
//when the value is created, 
class CategoryModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  CategoryModel({
    required this.name,
    this.isDeleted = false,
    required this.type,
  }){
    //we are sending id to database, a databse will create a id as default and 
    //we can use that id also , but here we are creating an id and sending it to
    //database, so that we can use this for deleting id and puttig also
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

}
