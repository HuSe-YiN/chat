import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_model.dart';

class FirestoreUserService {

  //? class convert to singleton
  static FirestoreUserService? _instance;
  factory FirestoreUserService() => _instance ??= FirestoreUserService._();
  FirestoreUserService._();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // get collections reference
  CollectionReference<MyUser> get getUsersCollection =>db.collection('Users').withConverter<MyUser>(fromFirestore: (snapshot, options) => MyUser.fromMap(snapshot.data()!), toFirestore: (user,_) => user.toMap());
  Stream<QuerySnapshot<MyUser>> get getUsersCollectionSnapshotStream => getUsersCollection.snapshots();
  // get users stream
  Stream<List<MyUser>> getUsersStream() {
    return getUsersCollectionSnapshotStream.map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  // add user
  Future<void> addUser(MyUser user) async {
    await getUsersCollection.add(user);
    // await db.collection('users').doc(user.uid).set(user.toMap());
  }

  // get users
  Future<List<MyUser>> getUsers() async {
    QuerySnapshot<MyUser> querySnapshot =
        await getUsersCollection.get();
    List<MyUser> users = querySnapshot.docs.map((doc) => doc.data()).toList();
    return users;
  }
}

FirestoreUserService fUserService = FirestoreUserService();
