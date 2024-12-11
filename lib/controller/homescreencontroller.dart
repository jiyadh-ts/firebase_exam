
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homescreencontroller with  ChangeNotifier {
  var db = FirebaseFirestore.instance;
  bool isloading=false;
  void addData({ required String name,required String duration,required String time})async{
    // Add a new document with a generated id.
final data = {"name": name, "duration": duration,"time":time};

 await db.collection("course").add(data).then((documentSnapshot) =>
    print("Added Data with ID: ${documentSnapshot.id}"));
  }

  void updateData({required String name,required String duration,required String time,required String docId })async{
final data = {"name": name, "duration": duration,"time":time};

await db.collection("course").doc(docId).update(data).then((documentSnapshot) =>print("document updated successfully")
   );
  
  }
  void ondelete({required String docid}){
    db.collection("course").doc(docid).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }


  
}