import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redditt_demo/features/auth/controller/auth_controller.dart';

import '../../theme/pallete.dart';
import '../constants/constants.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({Key? key}) : super(key: key);

  void signInWithGoogle( BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
          onPressed: ()=> signInWithGoogle(context,ref),
          icon: Image.asset(Constants.googlePath,width: 38),
          label: Text("Continue with Google",style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
              minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
      ),
    );
  }
}
