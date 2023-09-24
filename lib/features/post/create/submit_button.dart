import 'package:flutter/material.dart';
import 'package:nippo/features/post/model/post.dart';
import 'package:nippo/states/progress_hub_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/auth_state.dart';
import '../../../theme.dart';
import '../post_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.formKey,
    required this.controller,
  });

  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controller;

  @override
  Widget build(BuildContext context) {
    final uid = context.select((AuthState s) => s.user.uid);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        foregroundColor: VIC.red,
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final progressController = context.read<ProgressHUDController>()
            ..update(newState: true);
          final post = Post(
            title: controller['title']!.text,
            description: controller['description']!.text,
          );
          await context.read<PostController>().create(post: post, uid: uid);
          Navigator.pop(context);
          progressController.update(newState: false);
//          controller['title'].dispose();
//          controller['description'].dispose();
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          '投稿する',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
