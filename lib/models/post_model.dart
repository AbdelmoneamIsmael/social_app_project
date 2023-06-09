class Post {
  String? name;
  String? uid;
  String? postImage;
  String? dateTime;
  // String? postID;
  String? text;
  String? profileImage;
  Post({
    required String? name,
    required String? uid,
    required String? postImage,
    required String? dateTime,
    // required String? postID,
    required String? text,
    required String? profileImage,
  }) {
    this.name = name;
    this.uid = uid;
    this.postImage = postImage;
    this.dateTime = dateTime;
    // this.postID=postID;
    this.text = text;
    this.profileImage = profileImage;
  }

  Post.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    // postID=json['postID'];
    text = json['text'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'postImage': postImage,
      'dateTime': dateTime,
      // 'postID': postID,
      'text': text,
      'profileImage': profileImage,
    };
  }
}
