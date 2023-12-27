import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_network/helper/helper_function.dart';

class UserDataProvider extends ChangeNotifier {
  User? currentUser;
  Map<String, dynamic>? userData;

  Future<void> fetchUserDetails() async {
    currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(currentUser!.uid)
        .get();
    userData = snapshot.data();
    notifyListeners();
  }

  Future<void> saveUserData(String firstName, String lastName) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
      });
      fetchUserDetails(); // Обновить данные после сохранения
    } catch (e) {
      print('Ошибка при сохранении данных: $e');
    }
  }

  Future<void> login(context) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInAnonymously();
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }
}
