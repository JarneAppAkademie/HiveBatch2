import 'package:hive_flutter/hive_flutter.dart';
//wird gebraucht, damit der generator erkennt wovon der Adapter erzeugt werden soll
part 'User.g.dart';
//type id sollte unique sein
@HiveType(typeId: 0)
class User{
  // Hive field nummern sollten sich nicht doppeln
  @HiveField(0)
  String name;
  @HiveField(1)
  String email;
  // Functionen müssen wir nicht kennzeichnen
  User({required this.name, required this.email});
}