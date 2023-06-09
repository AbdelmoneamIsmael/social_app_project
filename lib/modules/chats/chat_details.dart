import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/chat_model.dart';
import 'package:socialapp/shared/colors/colors.dart';
import 'package:socialapp/social_cubit/social_cubit.dart';
import 'package:socialapp/social_cubit/social_state.dart';

import '../../models/user_model.dart';

class ChatDetails extends StatelessWidget {
  UserCreation? user;
  ChatDetails(this.user);
  SocialCubit? cubit;
  TextEditingController messageText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverID: user!.uid!);
        return BlocConsumer<SocialCubit, SocialState>(
          builder: (context, state) {
            cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(user!.image!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: SizedBox(width: 20),
                    ),
                    Text(
                      '${user!.name!}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                foregroundColor: Colors.black,
                centerTitle: true,
                elevation: 5,
              ),
              body: ConditionalBuilder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              MessageModel message = cubit!.messages[index];
                              if (user!.uid == message.senderId) {
                                return recieverBuildMessage(message);
                              } else {
                                return senderBuildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: cubit!.messages.length,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: messageText,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Write a message !'),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit!.getMessageImage().then((value) {
                                    print('slect image done successfully!');
                                    cubit!.uploadMessageImage();
                                  });
                                },
                                icon: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.blue,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  cubit!.sendMessage(
                                    receiverId: user!.uid,
                                    dateTime: DateTime.now().toString(),
                                    messageText: messageText.text,
                                    messagePhoto: state is UploadImageSuccess
                                        ?
                                        cubit!.newMessageImageLink
                                        :  '',
                                  );
                                  messageText.text = '';
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                                color: defultButtomColor,
                                minWidth: 20,
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                        state is LoadingUploadProfileImage
                            ? Center(child: CircularProgressIndicator())
                            : state is UploadImageSuccess
                                ? Container(
                                    width: 120,
                                    height: 150,
                                    child: Image(
                                        image: NetworkImage(
                                            cubit!.newMessageImageLink!)),
                                  )
                                : SizedBox(
                                    height: 2,
                                  ),
                      ],
                    ),
                  );
                },
                condition: state != SuccessGetMessagesState,
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
          listener: (context, state) {},
        );
      },
    );
  }

  Widget recieverBuildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Text(message.messageText!),
              message.messagePhoto!.length>1 ?
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20,),
                  Container(
                      height: 170,
                      width: 150,

                      child: Image(fit: BoxFit.cover,
                          image: NetworkImage( message.messagePhoto!))),

                ],) :
              SizedBox(height: 0,)
            ],

          ),
        ),
      );
  Widget senderBuildMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Text(
                message.messageText!,
                style: TextStyle(color: Colors.white),
              ),
             message.messagePhoto!.length>1 ?
                 Row(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                   SizedBox(height: 20,),
                   Container(
                     height: 170,
                       width: 150,

                       child: Image(fit: BoxFit.cover,
                           image: NetworkImage( message.messagePhoto!))),

                 ],) :
             SizedBox(height: 0,)
            ],
          ),
        ),
      );
}
