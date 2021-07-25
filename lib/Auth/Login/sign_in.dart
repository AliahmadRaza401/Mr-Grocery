import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
// import 'package:animation_wrappers/Animations/faded_translation_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groshop/Auth/login_navigator.dart';
import 'package:groshop/Components/custom_button.dart';
import 'package:groshop/Components/entry_field.dart';
import 'package:groshop/Locale/locales.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:groshop/Pages/Other/home_page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 0, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.welcomeTo,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                Spacer(
                  flex: 2,
                ),
                Image.asset(
                  "assets/logo.jpeg",
                  scale: 2.5,
                  height: 150,
                ),
                Spacer(
                  flex: 4,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      textItem(context, "Email", _emailController, false),
                      textItem(context, "Password", _passwordController, true),
                    ],
                  ),
                ),
                Spacer(),
                CustomButton(
                    label: "SignIn",
                    onTap: () async {
                      //             setState(() {
                      //   circular = true;
                      // });
                      try {
                        firebase_auth.UserCredential userCredential =
                            await firebaseAuth.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        print(userCredential.user.email);
                        // setState(() {
                        //   circular = false;
                        // });

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      } catch (e) {
                        final snackbar = SnackBar(
                            content: Text(
                                "Email or Password Not Matched, OR Check Network Connection"));
                        // final snackbar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        // setState(() {
                        //   circular = false;
                        // });
                      }
                    }),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If you don't have an account",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignInRoutes.signUp);
                      },
                      child: Text(
                        "  SignUp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                Text(
                  locale.orContinueWith,
                  textAlign: TextAlign.center,
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'Facebook',
                        color: Color(0xff3b45c1),
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        label: 'Google',
                        color: Color(0xffff452c),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Expanded buildFBGoogleButton(BuildContext context, String text, Color color) {
    return Expanded(
        child: FlatButton(
            color: color,
            onPressed: () => Navigator.pushNamed(context, SignInRoutes.signUp),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(text,
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )),
            )));
  }

  Widget textItem(context, String labeltext, TextEditingController controller,
      bool obscureText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 75,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: labeltext,
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.green,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
