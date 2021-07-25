import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:animation_wrappers/Animations/faded_translation_animation.dart';
import 'package:flutter/material.dart';
import 'package:groshop/Auth/Login/sign_in.dart';
import 'package:groshop/Auth/login_navigator.dart';
import 'package:groshop/Components/custom_button.dart';
import 'package:groshop/Components/entry_field.dart';
import 'package:groshop/Locale/locales.dart';
import 'package:groshop/Theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passworddController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  final _codeController = TextEditingController();

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  Future<bool> loginUser(String phone, BuildContext context) async {
    print("LoginUer Functiion");
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          var result = await _auth.signInWithCredential(credential);

          var user = result.user;

          if (user != null) {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => HomeScreen(user: user,)
            // ));
            print("Phone Okay");
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        var result =
                            await _auth.signInWithCredential(credential);

                        var user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                          print("Phone Okay 2");
                          try {
                            firebase_auth.UserCredential userCredential =
                                await firebaseAuth
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passworddController.text);
                            print(userCredential.user.email);

                            // setState(() {
                            //   circular = false;
                            // });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => SignIn()),
                                (route) => false);
                          } catch (e) {
                            // final snackbar = SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(e);
                            // fToast.showToast(
                            //   child: toastFail,
                            //   gravity: ToastGravity.BOTTOM,
                            //   toastDuration: Duration(seconds: 2),
                            // );
                            // setState(() {
                            //   circular = false;
                            // });
                          }
                          Navigator.of(context).pop();
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.register,
          style: TextStyle(color: kMainTextColor),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 1,
            ),
            textItem(
              context,
              "Full Name",
              _nameController,
            ),
            textItem(
              context,
              "Email",
              _emailController,
            ),
            textItem(
              context,
              "Password",
              _passworddController,
            ),
            textItem(
              context,
              "Number",
              _numberController,
            ),
            Spacer(
              flex: 5,
            ),
            CustomButton(onTap: () async {
              // final phone = _numberController.text.trim();

              // loginUser(phone, context);
              try {
                firebase_auth.UserCredential userCredential =
                    await firebaseAuth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passworddController.text);
                print(userCredential.user.email);

                // setState(() {
                //   circular = false;
                // });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignIn()),
                    (route) => false);
              } catch (e) {
                // final snackbar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(e);
                // fToast.showToast(
                //   child: toastFail,
                //   gravity: ToastGravity.BOTTOM,
                //   toastDuration: Duration(seconds: 2),
                // );
                // setState(() {
                //   circular = false;
                // });
              }
            })
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  Widget textItem(
    context,
    String labeltext,
    TextEditingController controller,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 75,
      child: TextFormField(
        controller: controller,
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
