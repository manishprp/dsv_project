import 'package:dsv_project/presentation/profile_screen/profile_screen.dart';

import '../../domain/model/user.dart';
import 'bloc/bloc/loginsignup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/alert.dart';
import '../../core/constants/size_constnts.dart';
import 'widget/app_button.dart';
import 'widget/app_text_input.dart';
import 'package:flutter/material.dart';

import '../../core/constants/stringconstants.dart';
import '../../core/validators.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginSignupScreen> {
  bool _isSignInMode = true;
  bool _isSignUpMode = false;

  final TextEditingController _emailController = TextEditingController(
    text: StringConstants.emptyString,
  );
  final TextEditingController _firstNameController = TextEditingController(
    text: StringConstants.emptyString,
  );
  final TextEditingController _lastNameController = TextEditingController(
    text: StringConstants.emptyString,
  );
  final TextEditingController _phoneNumberController = TextEditingController(
    text: StringConstants.emptyString,
  );
  final TextEditingController _passwordController = TextEditingController(
    text: StringConstants.emptyString,
  );
  final TextEditingController _confirmpPasswordController =
      TextEditingController(text: StringConstants.emptyString);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var width = size.width;

    return Scaffold(
      body: BlocConsumer<LoginsignupBloc, LoginsignupState>(
        listener: (context, state) {
          if (state is LoginsignupFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showPlatformMessage(context, state.errorMessage);
            });
          } else if (state is LoginsignupSuccess) {
            if (_isSignInMode) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showPlatformMessage(context, "Logged in successfully");
                navigateToProfileScreen(state.user);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showPlatformMessage(context, "User registered successfully");
                navigateToProfileScreen(state.user);
              });
            }
          }
        },
        builder: (context, state) {
          if (state is LoginsignupLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: width > 500 ? 500 : null,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.black.withAlpha(25)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppButton(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((
                                timeStamp,
                              ) {
                                setState(() {
                                  _isSignInMode = true;
                                  _isSignUpMode = false;
                                });
                              });
                            },
                            mode: _isSignInMode,
                            title: StringConstants.signIn,
                          ),
                          SizeConstants.gapW40,
                          AppButton(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((
                                timeStamp,
                              ) {
                                setState(() {
                                  _isSignInMode = false;
                                  _isSignUpMode = true;
                                });
                              });
                            },
                            mode: _isSignUpMode,
                            title: StringConstants.signUp,
                          ),
                        ],
                      ),
                      SizeConstants.gapH20,
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //// **** First Name ****
                            Visibility(
                              visible: _isSignUpMode,
                              child: AppTextInput(
                                validator: Validators.validateName,
                                controller: _firstNameController,
                                labelText: StringConstants.firstnameAst,
                              ),
                            ),
                            SizeConstants.gapH20,
                            //// **** Lastname Name ****
                            Visibility(
                              visible: _isSignUpMode,
                              child: AppTextInput(
                                validator: Validators.validateName,
                                controller: _lastNameController,
                                labelText: StringConstants.lastnameAst,
                              ),
                            ),
                            SizeConstants.gapH20,
                            //// **** PhoneNumber ****\
                            Visibility(
                              visible: _isSignUpMode,
                              child: AppTextInput(
                                validator: Validators.validatePhoneNumber,
                                controller: _phoneNumberController,
                                labelText: StringConstants.phoneNumberAst,
                              ),
                            ),
                            SizeConstants.gapH20,

                            //// **** EMAIL ****
                            AppTextInput(
                              controller: _emailController,
                              validator: Validators.validateEmail,
                              labelText: StringConstants.emailAst,
                            ),

                            SizeConstants.gapH20,
                            //// **** Password ****
                            AppTextInput(
                              validator: Validators.validatePassword,
                              controller: _passwordController,
                              labelText: StringConstants.passwordAst,
                            ),

                            SizeConstants.gapH20,
                            //// **** Confirm Password ****
                            Visibility(
                              visible: _isSignUpMode,
                              child: AppTextInput(
                                validator:
                                    (value) =>
                                        Validators.confirmPasswordValidate(
                                          _passwordController.text,
                                          value,
                                        ),
                                controller: _confirmpPasswordController,
                                labelText: StringConstants.confirmPasswordAst,
                              ),
                            ),
                            SizeConstants.gapH20,

                            AppButton(
                              horizontalPad: 30,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (_isSignUpMode) {
                                    context.read<LoginsignupBloc>().add(
                                      SignupEvent(
                                        user: User(
                                          firstname: _firstNameController.text,
                                          lastname: _lastNameController.text,
                                          email: _emailController.text,
                                          phonenumber:
                                              _phoneNumberController.text,
                                          password: _passwordController.text,
                                        ),
                                      ),
                                    );
                                  } else {
                                    context.read<LoginsignupBloc>().add(
                                      LoginEvent(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                }
                              },
                              mode: true,
                              title:
                                  _isSignInMode
                                      ? StringConstants.signIn
                                      : StringConstants.signUp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  navigateToProfileScreen(User user) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
    );
  }
}
