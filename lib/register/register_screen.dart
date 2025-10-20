import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/login/widgets/costtum_Elevated_button.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dialog_utiles.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:provider/provider.dart';

import '../providers/app_language_provider.dart';
import '../providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _languageController = ValueNotifier<bool>(false);
  TextEditingController emailController = TextEditingController(
      text: 'mariam@gmail.com');

  TextEditingController passwordController = TextEditingController(
      text: '1132005');

  TextEditingController nameController = TextEditingController(text: 'mariam');

  TextEditingController rePasswordController = TextEditingController(
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.trancColor,
          title: Text('Register', style: TextStyle(color: AppColors.blueColor)),
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.blueColor),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
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
                          hintText: AppLocalizations.of(context)!.name,
                          prefixIcon: Icon(Icons.person),
                          controller: nameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        CostumeFormField(
                          hintText: AppLocalizations.of(context)!.email,
                          prefixIcon: Icon(Icons.email),
                          KeyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
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
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        CostumeFormField(
                          hintText: AppLocalizations.of(context)!.re_password,
                          controller: rePasswordController,
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(CupertinoIcons.eye_slash),
                          obscureText: true,
                          KeyboardType: TextInputType.number,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please re_enter password';
                            }
                            if (text != passwordController.text) {
                              return 'Enter the same password';
                            }
                            return null;
                          },
                        ),

                        CostumeElevatedButton(
                          onPressed: register,
                          hasIcon: true,
                          childIconWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(AppLocalizations.of(context)!.create_account,
                                  style: AppStyles.MidWhite20),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.already,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineMedium
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: AppStyles.bold16Blue.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blueColor,
                                ),
                              ),
                            ),
                          ],
                        ),
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(massage: 'Loading.....', context: context);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);

        DialogUtils.hiddenDialog(context: context);
        DialogUtils.alertMassage(massage: 'Register successfully',
            context: context,
            title: 'Success',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.RouteHomeScreen,
                    (route) => false,);
            }
        );
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hiddenDialog(context: context);
          DialogUtils.alertMassage(
            massage: 'The password provided is too weak', context: context,
            title: 'Error',
            posActionName: 'Ok',
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hiddenDialog(context: context);
          DialogUtils.alertMassage(
            massage: 'The account already exists for that email.',
            context: context,
            title: 'Error',
            posActionName: 'Ok',
          );
        }
      } catch (e) {
        DialogUtils.hiddenDialog(context: context);
        DialogUtils.alertMassage(massage: e.toString(), context: context,
          title: 'Error',
          posActionName: 'Ok',
        );
      }
    }
  }
}
