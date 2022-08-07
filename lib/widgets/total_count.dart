import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// EXTRA CREDIT: StreamBuilder for the total quantity of waste food
 Widget totalCount(BuildContext context){
  
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int totalCount = 0;
        if (snapshot.hasData) {
          for( var i = 0 ; i < snapshot.data!.docs.length; i++ ) { 
            var post = snapshot.data!.docs[i];
            totalCount += post['quantity'] as int;
          }
          return Text(
            "Wasteagram - Total Count: $totalCount", 
            style: const TextStyle(fontWeight: FontWeight.bold),);
        } else {
          return const Text("Wasteagram", style: TextStyle(fontWeight: FontWeight.bold));}
      },
    );

  }