import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_model.dart';

class FirestoreChatService {
  //? class convert to singleton
  static FirestoreChatService? _instance;
  factory FirestoreChatService() => _instance ??= FirestoreChatService._();
  FirestoreChatService._();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<ChatModel> get getChatCollection =>
      db.collection('Chats').withConverter<ChatModel>(fromFirestore: (snapshot, options) => ChatModel.fromMap(snapshot.data()!), toFirestore: (chatModel, _) => chatModel.toMap());

  Future<void> addChat(ChatModel chatModel) async {
    await getChatCollection.add(chatModel);
  }

  Future<List<ChatModel>> getChats() async {
    return await getChatCollection.get().then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<bool> findChat(String chatId) async {
    var chats = await getChats();
    return chats.any((element) => element.id == chatId);
  }
}

FirestoreChatService fChatService = FirestoreChatService();
