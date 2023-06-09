import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/social_cubit/social_cubit.dart';
import 'package:socialapp/social_cubit/social_state.dart';

import 'chat_details.dart';

class ChatScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    SocialCubit? cubit;
    return BlocConsumer<SocialCubit,SocialState>(
      builder: (context, state)  {
        cubit = SocialCubit.get(context);
        return ListView.separated(
        itemBuilder: (context, index) => chatMessages(cubit,index,context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(color: Colors.grey[300],height: 1),
        ),
        itemCount: cubit!.usersForChat.length,
      );
        },
      listener: (context, state) {},
    );
  }

  Widget chatMessages(SocialCubit? cubit,index,context) => InkWell(
    onTap: (){
    navto(context,ChatDetails(cubit.usersForChat[index]) );
    },
    child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(cubit!.usersForChat[index].image!),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: SizedBox(width: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cubit.usersForChat[index].name!}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'abdelmoneam is here :: Hrllo',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              )
            ],
          ),
        ),
  );
}
