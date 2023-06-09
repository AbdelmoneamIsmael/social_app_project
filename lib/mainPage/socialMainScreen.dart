import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/add_post/add_post.dart';
import 'package:socialapp/modules/loginModel/loginPages/loginPage.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/sharedpref/sharedPreferance.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../shared/colors/colors.dart';
import '../shared/var.dart';
import '../social_cubit/social_cubit.dart';
import '../social_cubit/social_state.dart';

class MainSocialScreen extends StatelessWidget {
  SocialCubit? cubit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      builder: (context, state) {
        cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit!.titles[cubit!.index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: HexColor('#0b3f8b'),
                  fontSize: 25),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_outlined),
                color: HexColor('#0b3f8b'),
              ),
              IconButton(
                onPressed: () {
                 print(messagingToken);
                 print('here');
                },
                icon: Icon(Icons.notifications_active),
                color: HexColor('#0b3f8b'),
              ),
              IconButton(
                icon: Icon(Icons.logout_outlined, color: HexColor('#cc2865')),
                onPressed: () {
                  CashHelper.removeDate(key: 'uID');
                  navAndReplace(context, LoginScreen());
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Feeds',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_card,
                ),
                label: 'Add post',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: cubit!.index,
            onTap: (value) {
              cubit!.changeButtomNavScreen(value,context);
            },
          ),
          body: cubit!.screens[cubit!.index],
        );
      },
      listener: (context, state) {
        if(state is AddPostState){
          navto(context, AddPost());
        }
      },
    );
  }
}
