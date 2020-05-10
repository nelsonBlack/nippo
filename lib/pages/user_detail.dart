import 'package:flutter/material.dart';
import 'package:nippo/components/profile_area.dart';
import 'package:nippo/components/profile_total_post_count.dart';
import 'package:nippo/models/post.dart';
import 'package:nippo/models/user.dart';
import 'package:nippo/components/post_data_list_view.dart';
import 'package:nippo/repositories/post_repository.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage({@required this.user});
  static const String routeName = '/user_detail';
  User user;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as UserDetailPage;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ProfileArea(user: args.user),
            FutureBuilder<List<Post>>(
              future: PostRepository().fetchByUser(uid: args.user.uid),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                final list = snapshot.data as List<Post>;
                return Column(
                  children: <Widget>[
                    ProfileTotalPostCount(postCount: list.length),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
