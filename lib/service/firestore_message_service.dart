import 'package:chat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_model.dart';

class FirestoreMessagesService {
  //? class convert to singleton
  static FirestoreMessagesService? _instance;
  factory FirestoreMessagesService() => _instance ??= FirestoreMessagesService._();
  FirestoreMessagesService._();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<ChatModel> get getChatCollection =>
      db.collection('Chats').withConverter<ChatModel>(fromFirestore: (snapshot, options) => ChatModel.fromMap(snapshot.data()!), toFirestore: (chatModel, _) => chatModel.toMap());
  CollectionReference<MessageModel> get getMessagesCollection => db
      .collection('Messages')
      .withConverter<MessageModel>(fromFirestore: (snapshot, options) => MessageModel.fromMap(snapshot.data()!), toFirestore: (messageModel, _) => messageModel.toMap());
  
   Future addMessage(MessageModel message) async {
    await getMessagesCollection.add(message);
  }

  Future getMessages()async{
    var messages=  await getMessagesCollection.get().then((value) => value.docs.map((e) => 
    e.data()).toList());

    return messages;
  }

  Future saveMessage(String chatId, MessageModel message )async{
    QuerySnapshot<ChatModel> chats = await getChatCollection.get();
    var chatIndex= chats.docs.indexWhere((element) => element.data().id == chatId);
    // chat.data().messages?.add(message);
    var messages = chats.docs[chatIndex].data().messages;
    if(chatIndex != -1){
      await getChatCollection.doc(chats.docs[chatIndex].id).update({'messages': [messages,message]});
    }


  }
}

FirestoreMessagesService fMessageService = FirestoreMessagesService();
