import 'package:chat/models/chat_model.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/service/auth_service.dart';
import 'package:chat/service/firestore_chat_service.dart';
import 'package:chat/service/firestore_message_service.dart';
import 'package:chat/util/helper.dart';
import 'package:chat/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

// letgo JWT token = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjAzNDY5MzcsImppZCI6IjgzNjU2MzI5X29seHRyQG9seHRyIn0.OnJZ7aMY4Iyqf650FncJqlWWUL6Mx4EUfzGhiNaoMn4
class ChatScreen extends StatefulWidget {
  final MyUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MyUser get user => widget.user;
  late List<Widget> messagesWidgets;
  late String chatId;

  @override
  void initState() {
    messagesWidgets = [];
    //TODO firebaseden mesajlar çekilecek
    createChat();
    super.initState();
  }

  Future createChat() async {
      chatId = Helper.createChatId(user.uid!);
    if (!await fChatService.findChat(chatId)) {
      var chatModel = ChatModel(id: chatId, createTime: DateTime.now(), lastMessage: null, userIds: [widget.user.uid!, authService.currentUser!.uid!], chatType: ChatType.user);
      await fChatService.addChat(chatModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(children: messagesWidgets),
            ),
            sendMessageBox()
          ],
        ),
      ),
    );
  }

  createTextBouble(String message, bool isSender) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        TextBouble(message: message, isSender: isSender),
      ],
    );
  }

  sendMessageBox() {
    TextEditingController messageController = TextEditingController();
    return Card(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Mesaj',
                border: InputBorder.none,
                prefixText: "   ",
              ),
            ),
          ),
          IconButton(
              onPressed: () async {
                DateTime time = DateTime.now();
                MessageModel message =
                    MessageModel(id: time.millisecondsSinceEpoch.toString(), message: messageController.text.trim(), senderId: authService.currentUser!.uid!, receiverId: widget.user.uid!, time: time.millisecondsSinceEpoch);
                // await fMessageService.addMessage(message);
                await fMessageService.saveMessage(chatId, message);
                setState(() {
                  messagesWidgets.add(createTextBouble(messageController.text.trim(), true));
                  messageController.clear();
                });
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
