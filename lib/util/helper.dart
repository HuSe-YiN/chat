import 'package:chat/service/auth_service.dart';
import 'package:flutter/foundation.dart';

class Helper {
  static String getTime() {
    return DateTime.now().toLocal().toString();
  }

  static String createChatId(String receiverId) {
    debugPrint("--- receiverId $receiverId");
    debugPrint("--- senderId ${authService.currentUser!.uid!}");
    String senderId = authService.currentUser!.uid!;
    var mergeIdList = [...senderId.split(""), ...receiverId.split("")];
    mergeIdList.sort();

    return mergeIdList.join();
  }
}
