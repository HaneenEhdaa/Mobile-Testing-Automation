import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_shoppingapp/views/sign_up.dart';
import 'package:firebase_auth_shoppingapp/views/user_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_shoppingapp/views/products_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _SignUpState();
}

class _SignUpState extends State<Login> {
  bool hiddenpass = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController favHobbyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.emoji_emotions_sharp,
                    color: Color.fromARGB(255, 162, 25, 130),
                    size: 100,
                  ),
                ),
                Text(
                  "Add User Information",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 162, 25, 130),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                    labelText: "Age",
                    prefixIcon: Icon(
                      Icons.numbers_outlined,
                      color: Color.fromARGB(255, 162, 25, 130),
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextFormField(
                controller: favHobbyController,
                decoration: InputDecoration(
                  labelText: "Favourite Hobby",
                  prefixIcon: Icon(
                    Icons.favorite_border_sharp,
                    color: Color.fromARGB(255, 162, 25, 130),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FilledButton(
                    onPressed: () async {
                      var db = FirebaseFirestore.instance;
                      final data = {
                        "name": nameController.text,
                        "age": ageController.text,
                        "favHobby": favHobbyController.text
                      };

                      db.collection("User").add(data).then((documentSnapshot) {
                        nameController.clear();
                        ageController.clear();
                        favHobbyController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("User's data added successfuly"),
                          backgroundColor: Colors.green,
                        ));
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FilledButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetails()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: Text(
                      
                      "view",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    favHobbyController.dispose();
    super.dispose();
  }
}
