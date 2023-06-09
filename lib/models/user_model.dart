class UserCreation{
  String? email;
  String? name;
  String? password;
  int? phone;
  String? address;
  String? uid;
  String? image;
  String? coverImage;
  bool? isVerified;
  String? bio;

  UserCreation({
    required String email,
    required String password,
    required int phone,
    required  String address,
    required String uid,
    required String image,
    required coverImage,
    required bool isVerified,
    required String bio,
    required String name,
}){
    this.email=email;
    this.password=password;
    this.phone=phone;
    this.address=address;
    this.uid=uid;
    this.image=image;
    this.coverImage=coverImage;
    this.isVerified=isVerified;
    this.bio=bio;
    this.name=name;
  }

  UserCreation.fromJson(Map<String,dynamic> json){
    email=json['email'];
    password=json['password'];
    phone=json['phone'];
    address=json['address'];
    uid=json['uid'];
    image=json['image'];
    coverImage=json['coverImage'];
     isVerified=json['isVerified'];
     bio=json['bio'];
     name=json['name'];
  }

  Map<String,dynamic> toMap(){
    return {
      'bio': bio,
      'name': name,
      'email': email,
      'password':password,
      'phone': phone,
      'address':address,
      'uid': uid,
      'image':image,
      'coverImage':coverImage,
      'isVerified':isVerified,

    };
  }

}