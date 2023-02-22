import 'package:flutter/material.dart';
import 'package:hive_lessons/univer_data.dart';


class ViewUniversPage extends StatelessWidget {
  final UniverResponse? data;

  const ViewUniversPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.name ?? ""),
      ),
      body: ListView.builder(
          itemCount: data?.univers.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.lightBlue,
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(data?.univers[index].name ?? ""),
                  Text(data?.univers[index].webPages?.first ?? ""),
                ],
              ),
            );
          }),
    );
  }
}