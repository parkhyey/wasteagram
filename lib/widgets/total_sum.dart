import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// EXTRA CREDIT: Display the total sum of wasted items
class TotalSum extends StatelessWidget {
  const TotalSum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int sum = 0;
        if (snapshot.hasData) {
          for( var i = 0 ; i < snapshot.data!.docs.length; i++ ) { 
            var post = snapshot.data!.docs[i];
            sum += post['quantity'] as int;
          }
          return Text(
            "Wasteagram - Total Sum: $sum", 
            style: const TextStyle(fontWeight: FontWeight.bold),);
        } else {
          return const Text("Wasteagram", 
            style: TextStyle(fontWeight: FontWeight.bold));}
      },
    );
  }

}