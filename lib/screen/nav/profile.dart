import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapakberkah77/services/auth.dart';

// ignore: use_key_in_widget_constructors
class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final userCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> edit(String field) async {
    String newData= "";
    await showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter New $field',
          ),
          onChanged: (value){
            newData = value;
          },
        ),
        actions: [
          //cancel
          TextButton(onPressed: () => Navigator.pop(context), 
            child: const Text('Cancel')
            ),

          //save
          TextButton(onPressed: () => Navigator.of(context).pop(newData), 
            child: const Text('Save')
            ),
        ],
      )
    );
    if (newData.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newData});
    }
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return Container(
              padding: MediaQuery.of(context).padding,
              width: double.infinity,
              child: ListView(
                children: [
                  const Icon(
                    Icons.person,
                    size: 50,
                  ),
                  Cards(
                    text: userData['username'],
                    sectionName: 'Username',
                    onPressed: () => edit('username'),
                  ),
                  Cards(
                    text: userData['phone'],
                    sectionName: 'Phone',
                    onPressed: () => edit('phone'),
                  ),
                  Cards(
                    text: userData['address'],
                    sectionName: 'Address',
                    onPressed: () => Navigator.pushNamed(context, '/map')
                  ),
                  const LogOutButton(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        Authservice().signOut();
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout),
          Padding(padding: EdgeInsets.only(left: 5)),
          Text(
            'Log Out',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;

  const Cards({
    required this.text,
    required this.sectionName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$sectionName:'),
                IconButton(onPressed: onPressed, icon: const Icon(Icons.edit))
              ],
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
