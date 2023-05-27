import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:hive/hive.dart';

class ScoreScreen extends StatefulWidget {
  UserModel userModel;
  ScoreScreen({super.key, required this.userModel});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  var boxkisiDB = Hive.box<UserModel>('kisiDB');
  List<UserModel> tumKisiler = [];

  @override
  void initState() {
    super.initState();
    for (var element in boxkisiDB.values) {
      tumKisiler.add(element);
    }
    for (var element in tumKisiler) {
      debugPrint(element.userMail);
      debugPrint(element.userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text('Home'),
        ),
        body: ListView.builder(
          itemCount: tumKisiler.length,
          itemBuilder: (context, index) {
            return Card(
              color: tumKisiler[index].userID == widget.userModel.userID
                  ? Colors.green
                  : Colors.white,
              child: ListTile(
                title: Text(tumKisiler[index].userName),
                subtitle: Text(tumKisiler[index].enyuksekPuan.toString()),
              ),
            );
          },
        ));
  }
}
