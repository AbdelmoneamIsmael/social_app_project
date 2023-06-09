import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/social_cubit/social_cubit.dart';
import 'package:socialapp/social_cubit/social_state.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit? cubit;
    return BlocConsumer<SocialCubit, SocialState>(
      builder: (context, state) {
        cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(alignment: Alignment(-.90, -.2), children: [
                  Card(
                    elevation: 10.0,
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: AssetImage('assets/images/facepost.jpg'),
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    'YOu Can contact with your friends\n                      from chat!',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ]),


                ConditionalBuilder(
                    condition: cubit!.isLoadingPosts && cubit!.allpostsLoaded==true&&cubit!.allLikspostsLoaded==true,
                    builder:(context) =>  Center(child: CircularProgressIndicator()) ,
                    fallback: (context) =>ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buldPost(
                        context,
                        cubit!,
                        cubit!.feedPosts![index],
                        cubit!.postsID[index],
                        index,
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 7),
                      itemCount: cubit!.postLikes.length,
                    ) ,
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  buldPost(context, SocialCubit? cubit, Post postModel, postID, index) => Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${postModel.profileImage}'),
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
                              '${postModel.name}',
                              style: Theme.of(context).textTheme.bodyText1,
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
                          '${postModel.dateTime}',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.more_horiz_outlined)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '${postModel.text}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              //TAgs
              // Container(
              //   width: double.infinity,
              //   child: Wrap(children: [
              //     Container(
              //       height: 20,
              //       child: MaterialButton(
              //         minWidth: 1,
              //         padding: EdgeInsets.zero,
              //         onPressed: () {},
              //         child: Text(
              //           '#Software',
              //           style: TextStyle(
              //             color: Colors.lightBlueAccent,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 20,
              //       child: MaterialButton(
              //         minWidth: 1,
              //         padding: EdgeInsets.zero,
              //         onPressed: () {},
              //         child: Text(
              //           '#Software',
              //           style: TextStyle(
              //             color: Colors.lightBlueAccent,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 20,
              //       child: MaterialButton(
              //         minWidth: 1,
              //         padding: EdgeInsets.zero,
              //         onPressed: () {},
              //         child: Text(
              //           '#Software',
              //           style: TextStyle(
              //             color: Colors.lightBlueAccent,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 20,
              //       child: MaterialButton(
              //         minWidth: 1,
              //         padding: EdgeInsets.zero,
              //         onPressed: () {},
              //         child: Text(
              //           '#Software',
              //           style: TextStyle(
              //             color: Colors.lightBlueAccent,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 20,
              //       child: MaterialButton(
              //         minWidth: 1,
              //         padding: EdgeInsets.zero,
              //         onPressed: () {},
              //         child: Text(
              //           '#Happy_New_year',
              //           style: TextStyle(
              //             color: Colors.lightBlueAccent,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 20,
              //       child: MaterialButton(
              //         minWidth: 1,
              //         padding: EdgeInsets.zero,
              //         onPressed: () {},
              //         child: Text(
              //           '#Happy_New_year',
              //           style: TextStyle(
              //             color: Colors.lightBlueAccent,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ]),
              // ),
              if (postModel.postImage != '')
                Container(
                  padding: EdgeInsets.all(5),
                  height: 200,
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage('${postModel.postImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              Container(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${cubit!.postLikes[index]}',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: Colors.redAccent,
                                      ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        color: Colors.redAccent,
                                      ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage('${cubit!.userCreation!.image}'),
                            radius: 15,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Write a comment...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.postsLikes(postID);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Likes',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
