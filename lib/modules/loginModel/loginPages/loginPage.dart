import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/mainPage/socialMainScreen.dart';
import 'package:socialapp/modules/loginModel/cupitLogin/loginCubit.dart';
import 'package:socialapp/modules/loginModel/cupitLogin/loginState.dart';
import 'package:socialapp/modules/loginModel/loginPages/signUpPage.dart';

import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/sharedpref/sharedPreferance.dart';
import 'package:socialapp/shared/var.dart';

import '../../../shared/colors/colors.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController tEmail = TextEditingController();
  TextEditingController tPassword = TextEditingController();
  LoginPageCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("data", style: Theme.of(context).textTheme.bodyText1),
          ),
      body: BlocConsumer<LoginPageCubit, LoginPageState>(
        builder: (context, state) {
          cubit = LoginPageCubit.get(context);
          return Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(
                      'Welcome Back! ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image(
                      image: AssetImage('assets/images/img.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyTff(
                      TffID: tEmail,
                      preicon: Icon(
                        Icons.mail_outline,
                        color: Colors.blue,
                      ),
                      radius: 5,
                      lable: 'Email',
                      keyboardfor: TextInputType.emailAddress,
                      isEmpty: "Email mustn't Empty",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyTff(
                        TffID: tPassword,
                        preicon: Icon(
                          Icons.lock_outline,
                          color: Colors.blue,
                        ),
                        radius: 5,
                        lable: 'Password',
                        keyboardfor: TextInputType.text,
                        security: cubit!.isShowen,
                        isEmpty: 'Enter Password Please!',
                        posticon: cubit!.icon,
                        suffexpress: () {
                          cubit!.passwordVisability();
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.check_circle)),
                        SizedBox(
                          width: 3,
                        ),
                        Text('Remember Me'),
                        SizedBox(
                          width: 37,
                        ),
                        TextButton(
                            onPressed: () {}, child: Text('Forgot Password?')),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: ConditionalBuilder(
                        condition: state is! LoginLoading,
                        builder: (context) => Mybtn(
                          text: 'login',
                          color: defultButtomColor,
                          borderRedius: 25,
                          todo: () {
                            if (formKey.currentState!.validate()) {
                              cubit!.userLogin(
                                  email: tEmail.text, password: tPassword.text);
                            }
                          },
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Text(
                        'Or via social media',
                        style: TextStyle(color: hintColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/face.png'),
                          ),
                          SizedBox(width: 7),
                          Image(
                            image: AssetImage('assets/images/gmail.png'),
                          ),
                          SizedBox(width: 7),
                          Image(
                            image: AssetImage('assets/images/twiter.png'),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don’t have an account?'),
                        TextButton(
                            onPressed: () {
                              navto(context, SignUpPage());
                            },
                            child: Text('Register now'))
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('By signing up, you are agree with our '),
                          SizedBox(
                            width: 0,
                          ),
                          TextButton(
                              onPressed: () {}, child: Text('Terms & Conditions'))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginSuccess) {
            showToast(msg: 'Welcome Back !', state: toastState.success);
            CashHelper.setData(key: 'uID', value: cubit!.userID);
            UID=CashHelper.getData(key: 'uID');
            navAndReplace(context, MainSocialScreen());
          }
          if (state is LoginError) {
            showToast(
                msg: 'Failed Login Cheek your Email Or Pass',
                state: toastState.error);
          }
        },
      ),
    );
  }
}
