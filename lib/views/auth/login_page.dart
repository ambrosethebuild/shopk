import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:kushmarkets/bloc/base.bloc.dart';
import 'package:kushmarkets/bloc/login.bloc.dart';
import 'package:kushmarkets/constants/app_color.dart';
import 'package:kushmarkets/constants/app_images.dart';
import 'package:kushmarkets/constants/app_paddings.dart';
import 'package:kushmarkets/constants/app_routes.dart';
import 'package:kushmarkets/constants/app_strings.dart';
import 'package:kushmarkets/constants/app_text_styles.dart';
import 'package:kushmarkets/constants/strings/general.strings.dart';
import 'package:kushmarkets/constants/strings/login.strings.dart';
import 'package:kushmarkets/utils/ui_spacer.dart';
import 'package:kushmarkets/widgets/appbar/custom_leading_only_app_bar.dart';
import 'package:kushmarkets/widgets/appbar/empty_appbar.dart';
import 'package:kushmarkets/widgets/buttons/custom_button.dart';
import 'package:kushmarkets/widgets/inputs/custom_text_form_field.dart';
import 'package:kushmarkets/widgets/platform/platform_circular_progress_indicator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //login bloc
  LoginBloc _loginBloc = LoginBloc();
  //email focus node
  final emailFocusNode = new FocusNode();
  //password focus node
  final passwordFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    //listen to the need to show a dialog alert or a normal snackbar alert type
    _loginBloc.showAlert.listen((show) {
      //when asked to show an alert
      if (show) {
        EdgeAlert.show(
          context,
          title: _loginBloc.dialogData.title,
          description: _loginBloc.dialogData.body,
          backgroundColor: _loginBloc.dialogData.backgroundColor,
          icon: _loginBloc.dialogData.iconData,
        );
      }
    });

    //listen to state of the ui
    _loginBloc.uiState.listen((uiState) async {
      if (uiState == UiState.redirect) {
        // await Navigator.popUntil(context, (route) => false);
        Navigator.pushNamed(context, AppRoutes.homeRoute);
        // Navigator.pushNamedAndRemoveUntil(
        //   context,
        //   AppRoutes.homeRoute,
        //   (route) => false,
        // );
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      appBar: EmptyAppBar(),
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.appBackground(context),
      body: Stack(
        children: [
          //body
          CustomScrollView(
            slivers: <Widget>[
              //page intro image
              SliverToBoxAdapter(
                child: Hero(
                  tag: AppStrings.authImageHeroTag,
                  child: Image.asset(
                    AppImages.loginImage,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
              ),

              SliverPadding(
                padding: AppPaddings.defaultPadding(),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      //page title
                      Text(
                        LoginStrings.title,
                        style: AppTextStyle.h1TitleTextStyle(
                          color: AppColor.textColor(context),
                        ),
                        textAlign: TextAlign.center,

                      ),
                      UiSpacer.verticalSpace(space: 30),
                      //email/phone number textformfield
                      StreamBuilder<bool>(
                        stream: _loginBloc.validEmailAddress,
                        builder: (context, snapshot) {
                          return CustomTextFormField(
                            hintText: GeneralStrings.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textEditingController: _loginBloc.emailAddressTEC,
                            errorText: snapshot.error,
                            onChanged: _loginBloc.validateEmailAddress,
                            focusNode: emailFocusNode,
                            nextFocusNode: passwordFocusNode,
                          );
                        },
                      ),
                      UiSpacer.verticalSpace(space: 20),
                      //password textformfield
                      StreamBuilder<bool>(
                        stream: _loginBloc.validPasswordAddress,
                        builder: (context, snapshot) {
                          return CustomTextFormField(
                            hintText: GeneralStrings.password,
                            togglePassword: true,
                            obscureText: true,
                            textEditingController: _loginBloc.passwordTEC,
                            errorText: snapshot.error,
                            onChanged: _loginBloc.validatePassword,
                            focusNode: passwordFocusNode,
                          );
                        },
                      ),
                      UiSpacer.verticalSpace(space: 10),
                      //forgot password button
                      CustomButton(
                        onPressed: () {
                          //open forgot password page
                          Navigator.pushNamed(
                            context,
                            AppRoutes.forgotPasswordRoute,
                          );
                        },
                        child: Text(
                          LoginStrings.forgotPassword,
                          style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.accentColor,
                          ),
                          textAlign: TextAlign.start,

                        ),
                      ),
                      UiSpacer.verticalSpace(space: 10),
                      //login button
                      //listen to the uistate to know the appropriated state to put the login button
                      StreamBuilder<UiState>(
                        stream: _loginBloc.uiState,
                        builder: (context, snapshot) {
                          final uiState = snapshot.data;

                          return CustomButton(
                            padding: AppPaddings.mediumButtonPadding(),
                            color: AppColor.accentColor,
                            onPressed: uiState != UiState.loading
                                ? _loginBloc.processLogin
                                : null,
                            child: uiState != UiState.loading
                                ? Text(
                                    LoginStrings.title,
                                    style: AppTextStyle.h4TitleTextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                : PlatformCircularProgressIndicator(),
                          );
                        },
                      ),
                      UiSpacer.verticalSpace(space: 20),
                      //signup button
                      CustomButton(
                        padding: AppPaddings.mediumButtonPadding(),
                        color: Colors.white,
                        onPressed: () {
                          //open register page
                          Navigator.pushNamed(
                            context,
                            AppRoutes.registerRoute,
                          );
                        },
                        child: RichText(
                          textAlign: TextAlign.start,

                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: LoginStrings.needAccount,
                                style: AppTextStyle.h5TitleTextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColor.textColor(context),
                                ),
                              ),
                              TextSpan(
                                text: LoginStrings.signup,
                                style: AppTextStyle.h5TitleTextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primaryColorDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      UiSpacer.verticalSpace(space: 10),
                      //
                      Center(
                        child: Text(
                          LoginStrings.or,
                          style: AppTextStyle.h4TitleTextStyle(
                            color: AppColor.textColor(context),
                          ),
                          textAlign: TextAlign.start,

                        ),
                      ),
                      //
                      UiSpacer.verticalSpace(),
                      //social login
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //google login
                          StreamBuilder<UiState>(
                            stream: _loginBloc.uiState,
                            builder: (context, snapshot) {
                              final uiState = snapshot.data;

                              return CustomButton(
                                onPressed: uiState != UiState.loading
                                    ? _loginBloc.signinWithGoogle
                                    : null,
                                elevation: 3,
                                child: Row(
                                  children: [
                                    //

                                    Image.asset(
                                      AppImages.google_signin,
                                      height: 20,
                                      width: 20,
                                    ),
                                    //
                                    UiSpacer.horizontalSpace(space: 10),
                                    Text(
                                      LoginStrings.google,
                                      style: AppTextStyle.h5TitleTextStyle(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          UiSpacer.horizontalSpace(),
                          //facebook login
                          StreamBuilder<UiState>(
                            stream: _loginBloc.uiState,
                            builder: (context, snapshot) {
                              final uiState = snapshot.data;

                              return CustomButton(
                                onPressed: uiState != UiState.loading
                                    ? () =>
                                        _loginBloc.signinWithFacebook(context)
                                    : null,
                                color: Color(0xFF3b5998),
                                elevation: 3,
                                child: Row(
                                  children: [
                                    //
                                    Text(
                                      LoginStrings.facebook,
                                      style: AppTextStyle.h5TitleTextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      UiSpacer.verticalSpace(space: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //appbar
          CustomLeadingOnlyAppBar(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
