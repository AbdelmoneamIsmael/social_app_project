import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/social_cubit/social_cubit.dart';
import 'package:socialapp/social_cubit/social_state.dart';

import '../../shared/colors/colors.dart';
import '../../shared/components/components.dart';
import '../edit_profile_details/edit_profile_details.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit? cubit;
    return BlocConsumer<SocialCubit,SocialState>(
      builder: (context, state) {
        cubit=SocialCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 214,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
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
                            image: NetworkImage(cubit!.userCreation!.coverImage.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(cubit!.userCreation!.image.toString()),
                          radius: 47,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' ${cubit!.userCreation!.name}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                '${cubit!.userCreation!.bio.toString()}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 13),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'posts',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          Text(
                            '2000',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 13),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'likes',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          Text(
                            '5000',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 13),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'followers',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Column(
                        children: [
                          Text(
                            '1000',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 13),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'following',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.lightBlueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Mybtn(
                          text: 'Add Photos',
                          color: Theme.of(context).scaffoldBackgroundColor,
                          todo: () {},
                          borderRedius: 5,
                          textcolor: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 7,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: MaterialButton(
                          onPressed: () {
                            navto(context, EditProfileDetails());
                          },
                          child: Icon(Icons.edit_rounded),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      listener: (context, state) {

      },
    );
  }
}
