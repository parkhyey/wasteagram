import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/waste_post.dart';
import '../screens/detail_screen.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({Key? key}) : super(key: key);

  @override
  State<ListBuilder> createState() => _ListBuilderState();

}

class _ListBuilderState extends State<ListBuilder> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
        } 
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var post = snapshot.data!.docs[index];
            DateTime time = post['date'].toDate();

            return Semantics(
              label: 'Press for detail view.',
              button: true,
              enabled: true,
              child: ListTile(
                trailing: Text(post['quantity'].toString(),
                  style: Theme.of(context).textTheme.headline6),
                title:  Text(DateFormat.yMMMMEEEEd().format(time),
                  style: Theme.of(context).textTheme.headline6),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DetailScreen(post: post)));
                },
              )
            );
          }
        );
      },
    );
  }

}
