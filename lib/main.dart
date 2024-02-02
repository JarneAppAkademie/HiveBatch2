import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_workshop_batch2/User.dart';

void main() async{
  // Damit initialisieren wir Hive vor dem Starten der App
  await Hive.initFlutter();
  // Wir öffnen eine Box in die wir alle primitiven Datentypen speichern können
  var box = await Hive.openBox('testBox');
  // registriert den Adapter der es uns erlaubt User(also eigene Klassen) in Boxen zu speichern
  Hive.registerAdapter(UserAdapter());
  // für Boxen mit Listen oder Maps müssen wir den Datentyp angeben(beim öffnen/schließen/aufrufen)
  await Hive.openBox<List>('users');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // Liest die liste mit Usern aus der List Box aus
  List users = Hive.box<List>('users').get('personen') ?? [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hive showcase"),
        ),
        body: Column(
          children: [
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: emailController,
            ),
            ElevatedButton(onPressed: (){
              //speichert den Namen des Textfelds in der simplen Box
              Hive.box('testBox').put("name", nameController.text);
              // erstellt einen User aus den Textfield inputs
              User user = User(name: nameController.text, email: emailController.text);
              // fügt den user zur bestehenden Liste hinzu
              users.add(user);
              // läd die Liste mit dem neuen User in die List box
              Hive.box<List>('users').put('personen',users);
            }, child: Text("save name to box")),
            Text(Hive.box('testBox').get('name') ?? "no name saved"),
            Expanded(
              // ZEigt die Liste an Usern an
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context,index){
                  return Text(users[index].name);
              }),
            )
        ],)
      ),
    );
  }
}
