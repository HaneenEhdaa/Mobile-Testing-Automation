import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  _UserDetails createState() => _UserDetails();
}

class _UserDetails extends State<UserDetails> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('User').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "User Information",
          style: TextStyle(
              color: Color.fromARGB(255, 162, 25, 130),
              fontSize: 25,
              fontWeight: FontWeight.w200),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(
                      "Name: ${data['name']}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "Age: ${data['age']}\nHobby: ${data['favHobby']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
