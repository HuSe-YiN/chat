import 'package:chat/models/user_model.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/service/auth_service.dart';
import 'package:chat/service/firestore_user_service.dart';
import 'package:chat/util/extensions.dart';
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
            Text(authService.currentUser?.name ?? "null name"),
          ],
        ),
        actions: [
          IconButton(
            onPressed:()=> authService.logOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<MyUser>>(
          stream: fUserService.getUsersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];
                    return user.uid != authService.currentUser!.uid ? Container(
                      color: Colors.black,
                      child: ListTile(
                        selected: true,
                        selectedColor: Colors.blue,
                        title: Text(snapshot.data![index].email!),
                        onTap: () => context.push(ChatScreen(user: snapshot.data![index])),
                      ),
                    ): const SizedBox();
                  });
            }
            return const Center(
              child: Text("Empty Users Collection"),
            );
          }),
    );
  }
}
