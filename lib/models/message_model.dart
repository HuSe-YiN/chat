// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String id;
  final String message;
  final String senderId;
  final String receiverId;
  final int time;
  MessageModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.time,
  });

  MessageModel copyWith({
    String? id,
    String? message,
    String? senderId,
    String? receiverId,
    int? time,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'senderId': senderId,
      'receiverId':receiverId,
      'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      time: map['time'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, message: $message, sender: $senderId, receiverId:$receiverId, time: $time)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.message == message &&
      other.senderId == senderId &&
      other.receiverId == receiverId &&
      other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      message.hashCode ^
      senderId.hashCode ^
      receiverId.hashCode ^
      time.hashCode;
  }
}
