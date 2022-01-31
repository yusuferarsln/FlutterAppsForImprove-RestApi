import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_games_app/load_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<Welcome> apiCall() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    return Welcome.fromJson(jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<Welcome>(
          future: apiCall(),
          builder: (context, snapshot) {
            List<Datum> data = snapshot.data!.data;
            var growableList = [];
            var growableList2 = [];
            var growableList3 = [];
            for (var i = 0; i <= data.length - 1; i++) {
              growableList.add(data[i].firstName);
              growableList2.add(data[i].lastName);
              growableList3.add(data[i].avatar);
            }
            return ListView.builder(
              itemCount: growableList.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Container(child: Text(growableList[index])),
                    Container(child: Text(growableList2[index])),
                    Image.network(growableList3[index]),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
