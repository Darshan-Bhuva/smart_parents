import 'package:flutter/material.dart';
import 'package:smart_parents/components/background.dart';
// import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/components/responsive.dart';
import 'package:smart_parents/pages/Login/components/login_form.dart';
import 'package:smart_parents/pages/Login/components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                    // SizedBox(height: defaultPadding / 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // scrollDirection: Axis.vertical,
      // scrollDirection: Axis.horizontal,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const LoginScreenTopImage(),
          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
