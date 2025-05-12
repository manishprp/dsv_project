import 'package:dsv_project/core/local/store_user.dart';
import 'package:dsv_project/presentation/login_signup/login_signup_screen.dart';

import '../../domain/model/user.dart';
import 'bloc/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/alert.dart';
import '../../core/validators.dart';
import '../../core/constants/stringconstants.dart';
import '../login_signup/widget/app_button.dart';
import 'widget/profile_item.dart';
import 'package:flutter/material.dart';

import '../../core/constants/size_constnts.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool enabled = false;
  String buttonTitle = StringConstants.update;
  late final TextEditingController emailController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneNumberController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var user = widget.user;
    emailController = TextEditingController(text: user.email);
    firstNameController = TextEditingController(text: user.firstname);
    lastNameController = TextEditingController(text: user.lastname);
    phoneNumberController = TextEditingController(text: user.phonenumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var width = size.width;
    var isHorizontal = width > 500;

    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showPlatformMessage(context, "Profile updated successfully");
            });
          }
        },
        builder: (context, state) {
          if (state is ProfileSuccess) {
            var user = state.user;
            emailController.text = user.email ?? emailController.text;
            firstNameController.text =
                user.firstname ?? firstNameController.text;
            lastNameController.text = user.lastname ?? lastNameController.text;
            phoneNumberController.text =
                user.phonenumber ?? phoneNumberController.text;
          }

          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: isHorizontal ? 500 : null,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.black.withAlpha(25)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstants.profile,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                      SizeConstants.gapH20,
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ProfileItem(
                              validator: Validators.validateEmail,
                              controller: emailController,
                              title: StringConstants.email,
                              enabled: enabled,
                            ),
                            SizeConstants.gapH20,
                            ProfileItem(
                              validator: Validators.validateName,
                              enabled: enabled,
                              controller: firstNameController,
                              title: StringConstants.firstname,
                            ),
                            SizeConstants.gapH20,
                            ProfileItem(
                              validator: Validators.validateLastnameValidate,
                              enabled: enabled,
                              controller: lastNameController,
                              title: StringConstants.lastname,
                            ),
                            SizeConstants.gapH20,
                            ProfileItem(
                              validator: Validators.validatePhoneNumber,
                              enabled: enabled,
                              controller: phoneNumberController,
                              title: StringConstants.phoneNumber,
                            ),
                            SizeConstants.gapH20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppButton(
                                  mode: true,
                                  title: "Logout",
                                  onTap: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          StoreRetrieve.clearUser();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      LoginSignupScreen(),
                                            ),
                                          );
                                        });
                                  },
                                ),
                                AppButton(
                                  mode: true,
                                  title: buttonTitle,
                                  onTap: () {
                                    setState(() {
                                      if (enabled) {
                                        if (formKey.currentState!.validate()) {
                                          var user = widget.user.copyWith(
                                            firstNameController.text,
                                            lastNameController.text,
                                            emailController.text,
                                            phoneNumberController.text,
                                            null,
                                            null,
                                          );
                                          context.read<ProfileBloc>().add(
                                            UpdateEvent(user),
                                          );
                                          enabled = false;
                                          buttonTitle = StringConstants.update;
                                        }
                                      } else {
                                        enabled = true;
                                        buttonTitle = StringConstants.submit;
                                      }
                                    });
                                  },
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
            );
          }
        },
      ),
    );
  }
}
