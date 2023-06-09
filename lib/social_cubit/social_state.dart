abstract class SocialState {}

class InitialSocialState extends SocialState {}

class GetUserDataSuccess extends SocialState {}

class GetUserDataLoading extends SocialState {}

class GetUserDataFail extends SocialState {
  final String error;
  GetUserDataFail(this.error);
}
/////feeds/////////
class GetPostDataSuccess extends SocialState {}

class GetPostDataLoading extends SocialState {}

class GetPostDataFail extends SocialState {
  final String error;
  GetPostDataFail(this.error);
}

////// post likes////////////
class LoadingPostLikes extends SocialState {}

class SuccessPostLikes extends SocialState {}

class ErrorPostLikes extends SocialState {
  final String error;
  ErrorPostLikes(this.error);
}


class ChangeBotNavPage extends SocialState {}

class AddPostState extends SocialState {}

class PickImageSuccess extends SocialState {}

class PickImageFailed extends SocialState {
  // final String error;
  // PickImageFailed(this.error);
}

class UploadImageSuccess extends SocialState {}

class LoadingUploadProfileImage extends SocialState {}

class LoadingUploadCoverImage extends SocialState {}

class UploadImageFailed extends SocialState {
  // final String error;
  // PickImageFailed(this.error);
}

class LoadingUpdateUserData extends SocialState {}

class SuccessUpdateUserData extends SocialState {}

class FailUpdateUserData extends SocialState {
  final String error;
  FailUpdateUserData(this.error);
}

//posts
class LoadingUploadPostImage extends SocialState {}
class SuccessUploadPostImage extends SocialState {}
class FailUploadPostImage extends SocialState {}

class PostCreationLoading extends SocialState{}
class PostCreationSuccess extends SocialState{}
class PostCreationError extends SocialState{}

////////usersChat///////
 class LoadingALlUsersData extends SocialState{}
class SuccessALlUsersData extends SocialState{}
class FailALlUsersData extends SocialState{
  final String error;
  FailALlUsersData(this.error);
}
////////chats///////
class SuccessSendMessageState extends SocialState{}
class ErrorSendMessageState extends SocialState{}
class SuccessGetMessagesState extends SocialState{}
class ErrorGetMessagesState extends SocialState{}