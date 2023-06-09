import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/modules/loginModel/cupitLogin/loginCubit.dart';
import 'package:socialapp/modules/loginModel/cupitLogin/loginState.dart';
import 'package:socialapp/modules/loginModel/loginPages/loginPage.dart';

import 'package:socialapp/shared/components/components.dart';

import '../../../shared/colors/colors.dart';

class SignUpPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController tEmail = TextEditingController();
  TextEditingController tPassword = TextEditingController();
  TextEditingController tPhone = TextEditingController();
  TextEditingController tAddress = TextEditingController();
  TextEditingController tName = TextEditingController();
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
                      "Let's sign up Together!",
                      style: Theme.of(
                        context,
                      ).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Image(
                      image: AssetImage('assets/images/img2.png'),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    MyTff(
                      TffID: tName,
                      preicon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      radius: 5,
                      lable: 'Name',
                      keyboardfor: TextInputType.name,
                      isEmpty: "Name mustn't Empty",
                    ),
                    SizedBox(
                      height: 20,
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
                    MyTff(
                      TffID: tPhone,
                      preicon: Icon(
                        Icons.phone_enabled_outlined,
                        color: Colors.blue,
                      ),
                      radius: 5,
                      lable: 'Phone',
                      keyboardfor: TextInputType.phone,
                      isEmpty: "Phone mustn't Empty",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTff(
                      TffID: tAddress,
                      preicon: Icon(
                        Icons.home,
                        color: Colors.blue,
                      ),
                      radius: 5,
                      lable: 'Address',
                      keyboardfor: TextInputType.emailAddress,
                      isEmpty: "address mustn't Empty",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: ConditionalBuilder(
                          condition: state is!  RegisterLoading,
                          builder: (context) => Mybtn(
                            text: 'Sign Up Now!',
                            color: defultButtomColor,
                            borderRedius: 25,
                            todo: () {
                              if (formKey.currentState!.validate()) {
                                cubit!.userRegister(
                                  email: tEmail.text,
                                  phone: int.parse(tPhone.text.toString()),
                                  address: tAddress.text,
                                  password: tPassword.text,
                                  name: tName.text,
                                  isVerified:false,
                                );
                              }
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        )),
                    SizedBox(
                      height: 10,
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
                        Text('Already have an account?'),
                        TextButton(
                            onPressed: () {
                              navAndReplace(context, LoginScreen());
                            },
                            child: Text('Sign In Now'))
                      ],
                    ),
                    Row(
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
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is RegisterSuccess) {
            showToast(msg: "Great! let's sign in", state: toastState.success);
            navAndReplace(context, LoginScreen());
          }
          if (state is RegisterError) {
            showToast(
                msg: "password less than 5 letters or email not correct",
                state: toastState.error);
          }
        },
      ),
    );
  }
}
