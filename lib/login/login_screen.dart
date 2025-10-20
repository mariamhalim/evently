import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/login/widgets/costtum_Elevated_button.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dialog_utiles.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../model/my_user.dart';
import '../providers/app_language_provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_routes.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _languageController = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(
      text: 'mariam@gmail.com');

  TextEditingController passwordController = TextEditingController(
      text: '1132005');

  @override
  void initState() {
    super.initState();
    final languageProvider = context.read<AppLanguageProvider>();

    _languageController.value = languageProvider.appLanguage == 'ar';

    _languageController.addListener(() {
      if (_languageController.value) {
        languageProvider.changeLanguage('ar');
      } else {
        languageProvider.changeLanguage('en');
      }
    });
  }

  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage(AppAssets.Logo)),
                  SizedBox(height: height * 0.02),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CostumeFormField(
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIcon: Icon(Icons.email),
                          KeyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'Please enter email';
                            }
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(text);
                            if (!emailValid) {
                              return 'Please enter valid email ';
                            }
                            return null;
                          },
                        ),
                        CostumeFormField(
                          hintText: AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(CupertinoIcons.eye_slash),
                          obscureText: true,
                          KeyboardType: TextInputType.number,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'Please enter password';
                            }
                            if (text.length < 6) {
                              return 'password should be at least 6 numbers';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.forget_password,
                                style: AppStyles.bold16Blue.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blueColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        CostumeElevatedButton(
                          onPressed: login,
                          text: AppLocalizations.of(context)!.login,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context)!.have_account,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineMedium
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(AppRoutes.RegisterRouteScreen);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.create_account,
                                style: AppStyles.bold16Blue.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blueColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.blueColor,
                                thickness: 2,
                                indent: width * 0.04,
                                endIndent: width * 0.04,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.or,
                              style: AppStyles.MidBluet16,
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.blueColor,
                                thickness: 2,
                                indent: width * 0.04,
                                endIndent: width * 0.04,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        CostumeElevatedButton(
                          backgroundColor: AppColors.trancColor,
                          textStyle: AppStyles.MidBlue20,
                          hasIcon: true,
                          onPressed: loginWithGoogle,
                          borderColor: AppColors.blueColor,
                          childIconWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(image: AssetImage(AppAssets.google),
                                width: width * 0.04, height: height * 0.04,)
                              , SizedBox(
                                width: width * 0.02,
                              ),
                              Text(AppLocalizations.of(context)!
                                  .login_with_google,
                                  style: AppStyles.MidBlue20),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AdvancedSwitch(
                              controller: _languageController,
                              activeChild: const Text(
                                  "🇪🇬", style: TextStyle(fontSize: 22)),
                              inactiveChild: const Text(
                                  "🇺🇸", style: TextStyle(fontSize: 22)),
                              borderRadius: BorderRadius.circular(30),
                              width: 70,
                              height: 35,
                              activeColor: AppColors.blueColor,
                              inactiveColor: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(massage: 'Loading.....', context: context);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        DialogUtils.hiddenDialog(context: context);

        DialogUtils.alertMassage(
          massage: 'Login successfully',
          context: context,
          title: 'Success',
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.RouteHomeScreen,
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        print('Error code: ${e.code}');
        DialogUtils.hiddenDialog(context: context);

        if (e.code == 'user-not-found') {
          DialogUtils.alertMassage(
            massage: 'No user found for that email.',
            context: context,
            title: 'Error',
            posActionName: 'Ok',
          );
        } else if (e.code == 'wrong-password') {
          DialogUtils.alertMassage(
            massage: 'Wrong password provided for that user.',
            context: context,
            title: 'Error',
            posActionName: 'Ok',
          );
        } else {
          DialogUtils.alertMassage(
            massage: e.message ?? 'Something went wrong.',
            context: context,
            title: 'Error',
            posActionName: 'Ok',
          );
        }
      } catch (e) {
        DialogUtils.hiddenDialog(context: context);
        DialogUtils.alertMassage(
          massage: e.toString(),
          context: context,
          title: 'Error',
          posActionName: 'Ok',
        );
      }
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      DialogUtils.showLoading(
          massage: 'Signing in with Google...', context: context);


      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        DialogUtils.hiddenDialog(context: context);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;


      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );


      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        DialogUtils.hiddenDialog(context: context);
        return;
      }


      var myUser = await FirebaseUtils.readUserFromFireStore(user.uid);
      if (myUser == null) {
        myUser = MyUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await FirebaseUtils.addUserToFireStore(myUser);
      }


      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(myUser);

      DialogUtils.hiddenDialog(context: context);
      DialogUtils.alertMassage(
        massage: 'Login successfully with Google!',
        context: context,
        title: 'Success',
        posActionName: 'Ok',
        posAction: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.RouteHomeScreen);
        },
      );
    } catch (e) {
      DialogUtils.hiddenDialog(context: context);
      DialogUtils.alertMassage(
        massage: 'Google Sign-In failed: $e',
        context: context,
        title: 'Error',
        posActionName: 'Ok',
      );
    }
  }



}