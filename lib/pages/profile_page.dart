import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_network/provider/user_data_provider.dart';

class UserProfilePage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context);
    userProvider.fetchUserDetails(); // Загрузить данные пользователя

    return Scaffold(
      appBar: AppBar(
        title: const Text('Личный кабинет'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Привет, ${userProvider.userData?['firstName'] ?? 'Гость'}!'),
            const SizedBox(height: 20),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Фамилия'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userProvider.saveUserData(
                  firstNameController.text,
                  lastNameController.text,
                );
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
