import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/customAppBar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key,required this.snapshot});

  final DocumentSnapshot? snapshot;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  String getTime(Timestamp time) {
    DateTime date = time.toDate();
    return date.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 50, 50),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Detail Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.black,
              width: 350,
              height: 38,
              child: Text(
                "${widget.snapshot?.get('todo') ?? 'n'}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.black,
              width: 350,
              height: 350,
              child: Text(
                "${widget.snapshot?.get('detail') ?? 'n'}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.black,
              width: 350,
              height: 38,
              child: Text(
                getTime(widget.snapshot?.get('dateTime')),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
