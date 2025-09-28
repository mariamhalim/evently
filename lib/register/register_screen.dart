import 'package:evently/home/tabs/FavouriteTap/widget/costum_form_feild.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/login/widgets/costtum_e=button.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_language_provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  @override
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
                          text: AppLocalizations.of(context)!.create_account,
                          iconName: SizedBox(),
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
                            IconButton(
                              icon: const Text(
                                "🇺🇸",
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () =>
                                  languageProvider.changeLanguage('en'),
                            ),
                            IconButton(
                              icon: const Text(
                                "🇪🇬",
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () =>
                                  languageProvider.changeLanguage('ar'),
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

  void register() {
    if (formKey.currentState?.validate() == true) {}
  }
}
