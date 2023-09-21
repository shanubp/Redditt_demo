import 'package:flutter/material.dart';

import '../../../core/common/sign_in_button.dart';
import '../../../core/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(Constants.logoPath,height: 40),
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){}, child: Text("Skip",style: TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text("Dive into anything",style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 0.5),),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(Constants.logoPicPath),
          SizedBox(
            height: 30,
          ),
          SignInButton(),
        ],
      ),
    );
  }
}
