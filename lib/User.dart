import 'package:hive_flutter/hive_flutter.dart';

part 'User.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;

  User({required this.name, required this.email});
}