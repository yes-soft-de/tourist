class ChatModel {
  String sender;
  String sentDate;
  String msg;

  ChatModel.fromJson(Map<String, dynamic> jsonData) {
    sender = jsonData['sender'];
    msg = jsonData['msg'];
    sentDate = jsonData['sentDate'].toString();
  }
}