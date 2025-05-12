import '../../../core/constants/size_constnts.dart';
import '../../login_signup/widget/app_text_input.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final bool enabled;
  const ProfileItem({
    super.key,
    required this.controller,
    required this.title,
    this.validator,
    this.enabled = false,
  });

  @override
  Widget build(BuildContext context) {
    var isHorizontal = MediaQuery.sizeOf(context).width > 500;
    return LayoutBuilder(
      builder: (context, constraint) {
        return isHorizontal
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 1, child: Text("$title: ")),
                SizeConstants.gapW40,
                Expanded(
                  flex: 3,
                  child: AppTextInput(
                    validator: validator,
                    controller: controller,
                    labelText: title,
                    enabled: enabled,
                  ),
                ),
              ],
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$title: "),
                SizeConstants.gapH10,
                AppTextInput(
                  validator: validator,
                  controller: controller,
                  labelText: title,
                  enabled: enabled,
                ),
              ],
            );
      },
    );
  }
}
