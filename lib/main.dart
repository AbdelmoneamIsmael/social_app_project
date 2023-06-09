import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/loginModel/cupitLogin/loginCubit.dart';

import 'package:socialapp/shared/components/ThemeFile.dart';
import 'package:socialapp/shared/sharedpref/sharedPreferance.dart';
import 'package:socialapp/shared/var.dart';
import 'package:socialapp/social_cubit/social_cubit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'mainPage/socialMainScreen.dart';
import 'modules/loginModel/cupitLogin/bloc_observer.dart';
import 'modules/loginModel/loginPages/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  messagingToken =await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    print('here notification');
    print(event.data.toString());

  });

  FirebaseMessaging.onBackgroundMessage( _firebaseMessagingBackgroundHandler,);

  print( '    the token is   ${messagingToken} ');
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  Widget page;
  print(CashHelper.getData(key: 'uID'));
  var alreadyUser = CashHelper.getData(key: 'uID');
  if (alreadyUser != null) {
    UID=CashHelper.getData(key:'uID');
    page = MainSocialScreen();
  } else {
    page = LoginScreen();
  }

  runApp(MyApp(page));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data.toString()}");
}

class MyApp extends StatelessWidget {
  Widget? startScreen;
  MyApp(page) {
    startScreen = page;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginPageCubit(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()..getUserInformation()..getFeedPosts()..getAllUsers(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeDatalight(),
        home: startScreen,
      ),
    );
  }

}
