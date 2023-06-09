import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/models/chat_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/feeds/feeds_screen.dart';
import 'package:socialapp/modules/settings/settings_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/social_cubit/social_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/user_model.dart';
import '../modules/add_post/add_post.dart';
import '../shared/sharedpref/sharedPreferance.dart';
import '../shared/var.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(InitialSocialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  UserCreation? userCreation;
  getUserInformation() {
    emit(GetUserDataLoading());

    String UID = CashHelper.getData(key: 'uID');


    FirebaseFirestore.instance.collection('users').doc(UID).get().then((value) {


      userCreation = UserCreation.fromJson(value.data()!);

      emit(GetUserDataSuccess());
    }).catchError((error) {
      showToast(msg: error.toString(), state: toastState.error );
      emit(GetUserDataFail(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    AddPost(),
    UserScreen(),
    SettingScreen(),
  ];
  List<String> titles = [
    'New Feeds',
    'Chats',
    'add Post here',
    'User',
    'Settings',
  ];
  int index = 0;
  changeButtomNavScreen(int currentPage, context) {
    if (currentPage == 1) getAllUsers();
    if (currentPage == 2)
      emit(AddPostState());
    else {
      index = currentPage;
      emit(ChangeBotNavPage());
    }
  }

  File? profileImage;
  var profilePicker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile =
        await profilePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickImageSuccess());
    } else {
      showToast(msg: 'no Image selected', state: toastState.warning );
      emit(PickImageFailed());
    }
  }

  String? newProfileLink;
  Future<void> uploadProfileImage() async {
    emit(LoadingUploadProfileImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadImageSuccess());
        newProfileLink = value.toString();
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageFailed());
    });
  }

  String? newCoverLink;
  void uploadCoverImage() {
    emit(LoadingUploadCoverImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('covers/${Uri.file(newCoverImage!.path).pathSegments.last}')
        .putFile(newCoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadImageSuccess());
        newCoverLink = value.toString();
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageFailed());
    });
  }

  File? newCoverImage;
  var coverPicker = ImagePicker();
  Future<void> getCoverImage() async {
    final pickedFile = await coverPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      newCoverImage = File(pickedFile.path);
      emit(PickImageSuccess());
    } else {
      showToast(msg: 'no Image selected', state: toastState.warning );
      emit(PickImageFailed());
    }
  }

  void updateUserData(
    String? name,
    String? bio,
    int? phone,
    String? email,
    String? address,
  ) {
    if (profileImage != null) {
      if (newCoverImage != null) {
        update(
          address: address,
          email: email,
          phone: phone,
          bio: bio,
          name: name,
          coverLink: newCoverLink,
          profileLink: newProfileLink,
        );
        newCoverImage = null;
        profileImage = null;
      } else {
        print(newProfileLink);
        update(
          address: address,
          email: email,
          phone: phone,
          bio: bio,
          name: name,
          profileLink: newProfileLink,
        );
        profileImage = null;
      }
    } else if (newCoverImage != null) {
      print(newCoverLink);
      update(
        address: address,
        email: email,
        phone: phone,
        bio: bio,
        name: name,
        coverLink: newCoverLink,
      );
      newCoverImage = null;
    } else if (newCoverImage != null && profileImage != null) {
    } else {
      update(
        address: address,
        email: email,
        phone: phone,
        bio: bio,
        name: name,
      );
    }
  }

  update({
    String? name,
    String? bio,
    int? phone,
    String? email,
    String? address,
    String? profileLink,
    String? coverLink,
  }) {

    UserCreation user = UserCreation(
      bio: bio!,
      name: name!,
      email: email!,
      password: userCreation!.password!,
      phone: phone!,
      address: address!,
      uid: userCreation!.uid!,
      image: (profileLink == null) ? userCreation!.image! : profileLink,
      coverImage: (coverLink == null) ? userCreation!.coverImage! : coverLink,
      isVerified: userCreation!.isVerified!,
    );

    emit(LoadingUpdateUserData());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCreation!.uid)
        .update(user.toMap())
        .then((value) {
      getUserInformation();
      emit(SuccessUpdateUserData());
    }).catchError((error) {
      emit(FailUpdateUserData(error));
    });
  }

  ////////post/////////////////
  File? postImage;
  var postImagePicker = ImagePicker();
  Future<File?> getPostImage() async {
    final pickedFile =
        await postImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(PickImageSuccess());
      return postImage = File(pickedFile.path);


    } else {

      emit(PickImageFailed());
    }
  }

  String? newPostImageLink;
  Future<void> uploadPostImage(postImage) async {
    emit(LoadingUploadPostImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SuccessUploadPostImage());
        newPostImageLink = value.toString();

      }).catchError((error) {
        emit(FailUploadPostImage());
      });
    }).catchError((error) {
      emit(FailUploadPostImage());
    });
  }

  void createPost({
    required String? name,
    required String? uid,
    required String? postImage,
    required String? dateTime,
    required String? text,
    required String? profileImage,
  }) {
    emit(PostCreationLoading());
    Post postModle = Post(
        name: name,
        uid: uid,
        postImage: postImage,
        dateTime: dateTime,
        text: text,
        profileImage: profileImage);
    FirebaseFirestore.instance
        .collection('Posts')
        .add(postModle.toMap())
        .then((value) {
      emit(PostCreationSuccess());
    }).catchError((error) {
      emit(PostCreationError());
    });
  }

  //////////posts feeds//////////
  bool isThereIsPosts = false;
  List<Post>? feedPosts = [];
  List<String> postsID = [];
  List<int> postLikes = [];
  bool isLoadingPosts = true;
  void getFeedPosts() {
    emit(GetPostDataLoading());
    isLoadingPosts = true;
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      isThereIsPosts = true;
      value.docs.forEach((element) {
        // isLoadingPosts = true;
        element.reference.collection('Likes').get().then((value) {
          postLikes.add(value.docs.length);
        }).catchError((error) {
          print(error.toString());
          showToast(msg: error.toString(), state: toastState.error );
        });
        Post postModel = Post.fromJson(element.data());
        if (feedPosts == null) {
          postsID = [element.id];
          feedPosts = [postModel];
        } else {
          postsID.add(element.id);
          feedPosts!.add(postModel);
        }
      });
    }).then((value) {
      isLoadingPosts = false;
      emit(GetPostDataSuccess());
    }).catchError((error) {
      print(error.toString());
      showToast(msg: error.toString(), state: toastState.error );
      emit(GetPostDataFail(error.toString()));
    });
  }

  //////////post likes//////////
  void postsLikes(postID) {
    emit(LoadingPostLikes());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postID)
        .collection('Likes')
        .doc(userCreation!.uid)
        .set({'Like': true}).then((value) {
      emit(SuccessPostLikes());
    }).catchError((error) {
      print(error.toString());
      showToast(msg: error.toString(), state: toastState.error );
      emit(ErrorPostLikes(error));
    });
  }

  /////usersForChats////
  List<UserCreation> usersForChat = [];
  getAllUsers() {
    usersForChat = [];
    emit(LoadingALlUsersData());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      emit(SuccessALlUsersData());
      value.docs.forEach((element) {


        if (element.data()['uid'] != userCreation!.uid)
          usersForChat.add(UserCreation.fromJson(element.data()));
      });
    }).catchError((e) {
      emit(FailALlUsersData(e));
    });
  }

  ////chat message//////
  sendMessage({
    required receiverId,
    required dateTime,
    required messageText,
     messagePhoto = '',
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userCreation!.uid,
      receiverId: receiverId,
      dateTime: dateTime,
      messageText: messageText,
      messagePhoto: messagePhoto,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCreation!.uid)
        .collection("chat")
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError(() {
      emit(ErrorSendMessageState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection("chat")
        .doc(userCreation!.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SuccessSendMessageState());
    }).catchError(() {
      emit(ErrorSendMessageState());
    });
  }

  List<MessageModel> messages = [];
  getMessages({required String receiverID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userCreation!.uid)
        .collection('chat')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      emit(SuccessGetMessagesState());
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }

  File? messageImage;
  var messageImagePicker = ImagePicker();
  Future<void> getMessageImage() async {
    final pickedFile =
        await messageImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(PickImageSuccess());
    } else {
      showToast(msg: 'no Image selected', state: toastState.success );
      emit(PickImageFailed());
    }
  }

  String? newMessageImageLink;
  Future<void> uploadMessageImage() async {
    emit(LoadingUploadProfileImage());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadImageSuccess());
        newMessageImageLink = value.toString();
      }).catchError((error) {});
    }).catchError((error) {
      emit(UploadImageFailed());
    });
  }

}
