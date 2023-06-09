import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/social_cubit/social_state.dart';

import '../../shared/colors/colors.dart';
import '../../social_cubit/social_cubit.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit? cubit;
    TextEditingController postText = TextEditingController();
    return BlocConsumer<SocialCubit, SocialState>(
      builder: (context, state) {
        cubit = SocialCubit.get(context);

        var formKey = GlobalKey<FormState>();

        return Form(
          key: formKey,
          child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Create Post',
                  style: TextStyle(
                    color: HexColor('#0b3f8b'),
                  ),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: HexColor('#0b3f8b'),
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          var dateTime = DateTime.now();
                          cubit!.createPost(
                              name: cubit!.userCreation!.name,
                              uid: cubit!.userCreation!.uid,
                              postImage: cubit!.newPostImageLink ?? '',
                              dateTime: dateTime.toString(),
                              text: postText.text,
                              profileImage: cubit!.userCreation!.image);

                          // postText.text='';
                          // cubit!.newPostImageLink=null;
                          // cubit!.postImage=null;
                          // Navigator.pop(context);
                        }
                      },
                      child: state is PostCreationLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Publish!',
                              style: TextStyle(
                                color: HexColor('#0b3f8b'),
                              ),
                            ))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(cubit!.userCreation!.image!),
                          radius: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${cubit!.userCreation!.name}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.check,
                                      size: 10,
                                    ),
                                    radius: 7,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Publish',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: postText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must write something';
                        }
                      },
                      style: TextStyle(),
                      decoration: InputDecoration(
                        hintText:
                            "What is in your mind ${cubit!.userCreation!.name}..?",
                        border: InputBorder.none,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: cubit!.postImage != null
                              ? DecorationImage(
                                  image: FileImage(cubit!.postImage!)
                                      as ImageProvider,
                                  fit: BoxFit.cover,
                                  opacity:
                                      state is LoadingUploadPostImage ? .5 : 1,
                                )
                              : null,
                        ),
                      ),
                    ),
                    if (state is LoadingUploadPostImage)
                      LinearProgressIndicator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                cubit!.getPostImage().then((value) {
                                  cubit!.uploadPostImage(value);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_sharp,
                                    color: HexColor('#0b3f8b'),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Add photo',
                                    style: TextStyle(
                                      color: HexColor('#0b3f8b'),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              '# Add tags..',
                              style: TextStyle(
                                color: HexColor('#0b3f8b'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        );
      },
      listener: (context, state) {
        if (state is PostCreationSuccess) {
          postText.text = '';
          cubit!.newPostImageLink = null;
          cubit!.postImage = null;
          cubit!.feedPosts=[];
          cubit!.getFeedPosts();
          Navigator.pop(context);


        }
      },
    );
  }
}
