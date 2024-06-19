import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  //? class convert to singleton
  static FirestoreService? _instance;
  factory FirestoreService() => _instance ??= FirestoreService._();
  FirestoreService._();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<MyUser>> getUsersCollectionSnapshot() {
    return db.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MyUser.fromMap(doc.data())).toList();
    });
  }

  Future<void> addUser(MyUser user) async {
    await db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<List<MyUser>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('users').get();
    List<MyUser> users = querySnapshot.docs.map((e) => MyUser.fromMap(e.data())).toList();
    return users;
  }
}

FirestoreService firestoreService = FirestoreService();
