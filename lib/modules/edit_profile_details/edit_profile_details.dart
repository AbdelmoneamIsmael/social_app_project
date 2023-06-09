import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/edit_profile_details/profile_picker.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/social_cubit/social_cubit.dart';
import 'package:socialapp/social_cubit/social_state.dart';

import '../../shared/colors/colors.dart';
import 'cover_picker.dart';

class EditProfileDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit? cubit;
    TextEditingController tBio = TextEditingController();
    TextEditingController tName = TextEditingController();
    TextEditingController tPhone = TextEditingController();
    TextEditingController tAddress = TextEditingController();
    TextEditingController tEmail = TextEditingController();
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if(state is SuccessUpdateUserData){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        cubit = SocialCubit.get(context);
        tName.text = cubit!.userCreation!.name.toString();
        tBio.text = cubit!.userCreation!.bio.toString();
        tPhone.text = cubit!.userCreation!.phone.toString();
        tEmail.text = cubit!.userCreation!.email.toString();
        tAddress.text = cubit!.userCreation!.address.toString();
        var profileImage = cubit!.profileImage;
        var coverPic = cubit!.newCoverImage;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Editing',
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
              IconButton(
                  onPressed: () {
                    cubit!.updateUserData(
                      tName.text,
                      tBio.text,
                      int.parse(tPhone.text),
                      tEmail.text,
                      tAddress.text,
                    );
                  },
                  icon: Icon(
                    Icons.check,
                    color: HexColor('#0b3f8b'),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.all(10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is LoadingUpdateUserData) LinearProgressIndicator(),
                  if (state is LoadingUpdateUserData)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 214,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 164,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: (coverPic == null)
                                        ? NetworkImage(
                                            cubit!.userCreation!.coverImage
                                                .toString(),
                                          )
                                        : FileImage(coverPic) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                navto(context, CoverUploade());
                              },
                              icon: CircleAvatar(
                                  radius: 18,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 17,
                                  )),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  backgroundImage: (profileImage == null)
                                      ? NetworkImage(
                                          cubit!.userCreation!.image.toString())
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                  radius: 47,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                navto(context, ProfileUploade());
                              },
                              icon: CircleAvatar(
                                  radius: 18,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 17,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTff(
                    isEmpty: 'name here bro',
                    lable: 'name',
                    preicon: Icon(Icons.person),
                    TffID: tName,
                    radius: 5,
                    keyboardfor: TextInputType.name,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTff(
                    isEmpty: 'Bio here bro',
                    lable: 'Bio',
                    preicon: Icon(Icons.biotech_sharp),
                    TffID: tBio,
                    radius: 5,
                    keyboardfor: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTff(
                    isEmpty: 'phone here bro',
                    lable: 'phone',
                    preicon: Icon(Icons.phone),
                    TffID: tPhone,
                    radius: 5,
                    keyboardfor: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTff(
                    enable: false,
                    isEmpty: 'email here bro',
                    lable: 'Email',
                    preicon: Icon(Icons.biotech_sharp),
                    TffID: tEmail,
                    radius: 5,
                    keyboardfor: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyTff(
                    isEmpty: 'adress here bro',
                    lable: 'Address',
                    preicon: Icon(Icons.directions_bike),
                    TffID: tAddress,
                    radius: 5,
                    keyboardfor: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
