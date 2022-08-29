// ignore_for_file: file_names

class MessageModel {
  String type;
  String message;
  String? time;

  MessageModel({required this.message, required this.type, this.time});
}
