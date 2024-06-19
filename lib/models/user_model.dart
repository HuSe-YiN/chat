// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:chat/provider/global_datas.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyUser {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? image;
  MyUser({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.image,
  });

  MyUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    String? image,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  factory MyUser.fromFirebaseUser(User user) {
    return MyUser(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      image: user.photoURL,
      password: globalDatas.password,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyUser(uid: $uid, name: $name, email: $email, password: $password, image: $image)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.image == image;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      image.hashCode;
  }
}

