import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_exam/controller/homescreencontroller.dart';
import 'package:firebase_exam/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final Stream<QuerySnapshot> _courseStream =
      FirebaseFirestore.instance.collection('course').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        onNewData(context);
      }),
      body: StreamBuilder<QuerySnapshot>(
        stream: _courseStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                subtitle: Row(
                  children: [
                    Text(data['duration']),
                    SizedBox(width: 10,),
                     Text(data['time']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  IconButton(onPressed: (){
                    onupdateData(context, document.id, data);
                  }, icon: Icon(Icons.edit)),
                                    IconButton(onPressed: (){
                                      context.read<Homescreencontroller>().ondelete(docid: document.id);
                                    }, icon: Icon(Icons.delete))

                ],),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

onNewData(context) {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController durationcontroller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namecontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: durationcontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: timecontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          namecontroller.clear();
                          durationcontroller.clear();
                          timecontroller.clear();
                          onNewData(context);
                        },
                        child: Text("cancel")),
                    ElevatedButton(
                        onPressed: () {
                          context.read<Homescreencontroller>().addData(
                              name: namecontroller.text,
                              duration: durationcontroller.text,
                              time: timecontroller.text);
                        },
                        child: Text("Save")),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

//on update

onupdateData(context, String id, Map<String, dynamic> data) {
  final TextEditingController namecontroller =
      TextEditingController(text: data["name"]);
  final TextEditingController durationcontroller =
      TextEditingController(text: data["duration"]);
  final TextEditingController timecontroller =
      TextEditingController(text: data["time"]);

  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namecontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: durationcontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: timecontroller,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          namecontroller.clear();
                          durationcontroller.clear();
                          timecontroller.clear();
                          onNewData(context);
                        },
                        child: Text("cancel")),
                    ElevatedButton(
                        onPressed: () {
                          context.read<Homescreencontroller>().updateData(
                              name: namecontroller.text,
                              duration: durationcontroller.text,
                              time: timecontroller.text,
                              docId: id);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Data added updated Successfully")));
                        },
                        child: Text("Save")),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
