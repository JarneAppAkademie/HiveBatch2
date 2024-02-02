import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_workshop_batch2/User.dart';

void main() async{
  await Hive.initFlutter();
  var box = await Hive.openBox('testBox');

  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<List>('users');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
              Hive.box('testBox').put("name", nameController.text);
              User user = User(name: nameController.text, email: emailController.text);
              users.add(user);
              Hive.box<List>('users').put('personen',users);
            }, child: Text("save name to box")),
            Text(Hive.box('testBox').get('name') ?? "no name saved"),
            Expanded(
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
