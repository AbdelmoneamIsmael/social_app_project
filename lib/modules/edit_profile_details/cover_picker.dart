import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/components/components.dart';

import '../../shared/colors/colors.dart';
import '../../social_cubit/social_cubit.dart';
import '../../social_cubit/social_state.dart';

class CoverUploade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit? cubit;
    return BlocConsumer<SocialCubit, SocialState>(
      builder: (context, state) {
        cubit = SocialCubit.get(context);
        var coverPic = cubit!.newCoverImage;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Uploading Cover pic',
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
            actions: [],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Select your new Photo',
                        style:
                        TextStyle(color: HexColor('#0b3f8b'), fontSize: 25),
                      ),
                    ),
                    Mybtn(
                        text: 'select',
                        todo: () {
                          cubit!.getCoverImage();
                        },
                        width: 70,
                        height: 40),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: (coverPic == null)
                              ? NetworkImage(
                              cubit!.userCreation!.coverImage.toString())
                              : FileImage(coverPic) as ImageProvider,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                (state is LoadingUploadCoverImage)
                    ? Center(child: CircularProgressIndicator(),)
                    :Mybtn(
                  text: 'Upload this Image',
                  todo: () {
                    cubit!. uploadCoverImage();
                  },
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is UploadImageSuccess){
          Navigator.pop(context);
        }

      },
    );
  }
}
