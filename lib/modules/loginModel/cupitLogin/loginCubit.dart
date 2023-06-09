import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import 'loginState.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginInitState());
  static LoginPageCubit get(context) => BlocProvider.of(context);

  bool isShowen = true;
  IconData? icon = Icons.visibility_outlined;
  String? userID;
  passwordVisability() {
    isShowen = !isShowen;
    icon = isShowen ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(EyeChange());
  }

  userRegister({
    required String email,
    required int phone,
    required String address,
    required String password,
    required bool isVerified,
    required String name,
  }) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {

        print(value.user!.uid);
        userCreationMethod(
            email: email,
            phone: phone,
            address: address,
            name: name,
            password: password,
            uid: value.user!.uid,
            isVerified:isVerified
        );
        emit(RegisterSuccess());
      },

    ).catchError(
      (e) {
        emit(RegisterError(e.toString()));
      },
    );
  }

  UserCreation? userCreation;
  userCreationMethod({
    required String email,
    required int phone,
    required String address,
    required String password,
    required uid,
    required bool isVerified,
    required String name,

  }) {
    emit(CreationLoading());
    userCreation = UserCreation(
        email: email,
        password: password,
        phone: phone,
        address: address,
        name:name,
        uid: uid,
        isVerified:isVerified,
        image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1674767562~exp=1674768162~hmac=346e54a87d9b9af6930ab8ae318f6ab9231a5c7adf83f726aa39d78a9d1f6619',
        bio: 'Software Engineer',
        coverImage: 'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=900&t=st=1674767741~exp=1674768341~hmac=0d20933fa9cec7180ce5dffa40b3981888a277f033c4a0ce0212b3d600296b60'
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userCreation!.toMap())
        .then((value) {
      emit(CreationSuccess());
    }).catchError((error) {
      emit(CreationError(error));
    });
  }

  userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        emit(LoginSuccess());
       userID=value.user!.uid;
      },
    ).catchError(
      (e) {
        emit(LoginError(e.toString()));
      },
    );
  }
}
