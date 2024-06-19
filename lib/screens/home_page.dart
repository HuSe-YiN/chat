import 'package:chat/models/user_model.dart';
import 'package:chat/service/auth_service.dart';
import 'package:chat/service/firestore_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 10),
            Text(authService.currentUser?.email ?? "null email"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: authService.logOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<MyUser>>(
          stream: firestoreService.getUsersCollectionSnapshot(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.black,
                      child: ListTile(
                        selected: true,
                        selectedColor: Colors.blue,
                        title: Text(snapshot.data![index].email!),
                      ),
                    );
                  });
            }
            return const Center(
              child: Text("Empty Users Collection"),
            );
          }),
    );
  }
}
