class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? messageText;
  String? messagePhoto;

  MessageModel({
    required String? senderId,
    required receiverId,
    required dateTime,
    required messageText,
    required messagePhoto
  }) {
    this.senderId = senderId;
    this.receiverId = receiverId;
    this.dateTime = dateTime;
    this.messageText = messageText;
    this.messagePhoto=messagePhoto;
  }

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    messageText = json['messageText'];
    messagePhoto = json['messagePhoto'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'messageText': messageText,
      'messagePhoto': messagePhoto,
    };
  }
}
