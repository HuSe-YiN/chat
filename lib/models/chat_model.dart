// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:chat/models/message_model.dart';

class ChatModel {
  String? id;
  String? name;
  DateTime createTime;
  MessageModel? lastMessage;
  List<String> userIds;
  List<MessageModel>? messages;
  ChatType chatType;
  ChatModel({
    required this.id,
    this.name,
    required this.createTime,
    this.lastMessage,
    required this.userIds,
    this.messages,
    required this.chatType,
  });

  ChatModel.notId({
    this.name,
    required this.createTime,
    this.lastMessage,
    required this.userIds,
    required this.chatType,
  });

  ChatModel copyWith({
    String? id,
    String? name,
    DateTime? createTime,
    MessageModel? lastMessage,
    List<String>? userIds,
    List<MessageModel>? messages,
    ChatType? chatType,
  }) {
    return ChatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createTime: createTime ?? this.createTime,
      lastMessage: lastMessage ?? this.lastMessage,
      userIds: userIds ?? this.userIds,
      messages: messages ?? this.messages,
      chatType: chatType ?? this.chatType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createTime': createTime.millisecondsSinceEpoch,
      'lastMessage': lastMessage?.toMap(),
      'userIds': userIds,
      'messages': messages?.map((x) => x.toMap()).toList(),
      'chatType': chatType.index,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
        id: map['id'] != null ? map['id'] as String : null,
        name: map['name'] != null ? map['name'] as String : null,
        createTime: DateTime.fromMillisecondsSinceEpoch(map['createTime'] as int),
        lastMessage: map['lastMessage'] != null ? MessageModel.fromMap(map['lastMessage'] as Map<String, dynamic>) : null,
        userIds: List<String>.from(map['userIds']),
        messages: List<MessageModel>.from(map['messages'] ?? []),
        chatType: ChatType.values[map['chatType']]);
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, name: $name, createTime: $createTime, lastMessage: $lastMessage, userIds: $userIds, messages: $messages, chatType: $chatType)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createTime == createTime &&
        other.lastMessage == lastMessage &&
        listEquals(other.userIds, userIds) &&
        listEquals(other.messages, messages) &&
        other.chatType == chatType;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ createTime.hashCode ^ lastMessage.hashCode ^ userIds.hashCode ^ messages.hashCode ^ chatType.hashCode;
  }
}

enum ChatType {
  user,
  group,
}
