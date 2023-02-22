import 'package:hive/hive.dart';
part 'person_model.g.dart';

@HiveType(typeId:0)
class Person extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String gender;
  @HiveField(2)
  final int count;
  Person({required this.name, required this.gender, required this.count});

  factory Person.fromJson(Map data){
    return Person(name: data["name"], gender: data["gender"], count: data["count"]);
  }
}
