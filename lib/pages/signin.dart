import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nippo/components/app_logo.dart';
import 'package:nippo/components/signin_sns_btn.dart';
import 'package:nippo/constant.dart';
import 'package:nippo/pages/home.dart';
import 'package:nippo/services/auth.dart';
import 'package:nippo/stores/progress_hub_store.dart';
import 'package:provider/provider.dart';

@immutable
// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  static const String routeName = '/signin';
  static const double snsLogoHeight = 24;

  Image googleLogo = Image(
    image: ExactAssetImage(AssetPath.GOOGLE_LOGO_PATH),
    height: snsLogoHeight,
  );

  Image twitterLogo = Image(
    image: ExactAssetImage(AssetPath.TW_LOGO_PATH),
    height: snsLogoHeight,
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      Provider.of<ProgressHUDStore>(context, listen: false)
          .update(newState: true);
      final user = await Auth().signInWithGoogle();
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomePage.routeName,
            arguments: 'from google.');
      }
    } on Exception catch (e) {
      print(e);
    }
    Provider.of<ProgressHUDStore>(context, listen: false)
        .update(newState: false);
  }

  Future<void> signInWithTwitter(BuildContext context) {
    print('twitter is not unavaiable.');
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressHUDStore>(context).saving,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Hero(
                child: AppLogo(height: 160),
                tag: 'appLogo',
              ),
              const SizedBox(
                height: 80,
              ),
              SignInSnsBtn(
                logoImg: googleLogo,
                label: 'Sign in with Google',
                callback: () => signInWithGoogle(context),
              ),
              const SizedBox(
                height: 24,
              ),
              SignInSnsBtn(
                logoImg: twitterLogo,
                label: 'Sign in with Twitter',
                callback: () => signInWithTwitter(context),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
