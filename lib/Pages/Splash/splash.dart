import 'dart:async';
import 'package:flutter/material.dart';
import 'package:groshop/Auth/Login/sign_in.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  void nextScreen() {
    Timer(
        Duration(seconds: 4),
        // checkFirstSeen,
        () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignIn()))
            });
  }

  @override
  void initState() {
    super.initState();
    afterFirstLayout(context);
  }

  checkFirstSeen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignIn()));
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool _seen = (prefs.getBool('seen') ?? false);

    // if (_seen) {
    //   Navigator.of(context).pushReplacement(
    //       new MaterialPageRoute(builder: (context) => new Login()));
    // } else {
    //   await prefs.setBool('seen', true);
    //   Navigator.of(context).pushReplacement(
    //       new MaterialPageRoute(builder: (context) => new OnBoarding()));
    // }
  }

  @override
  void afterFirstLayout(BuildContext context) => nextScreen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/yLogo.jpeg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: Color(0xfffff951),
        child: Image.asset(
          "assets/yLogo.jpeg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}

// import 'dart:async';
//
// import 'package:after_layout/after_layout.dart';
// import 'package:event_app/Screens/Home/home.dart';
// import 'package:event_app/Screens/OnBoarding/onBoarding.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
//
//
// class Splash extends StatefulWidget {
//   @override
//   SplashState createState() => new SplashState();
// }
//
// class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
//   Future checkFirstSeen() async {
//
//     // Timer(
//     //     Duration(seconds: 7),
//     //         (){
//     //       Navigator.of(context).pushReplacement(
//     //           new MaterialPageRoute(builder: (context) => new OnBoarding()));
//     //     }
//     // );
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool _seen = (prefs.getBool('seen') ?? false);
//
//     if (_seen) {
//       Navigator.of(context).pushReplacement(
//           new MaterialPageRoute(builder: (context) => new Home()));
//     } else {
//       await prefs.setBool('seen', true);
//       Navigator.of(context).pushReplacement(
//           new MaterialPageRoute(builder: (context) => new OnBoarding()));
//     }
//   }
//
//   //Video setup
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     _controller = VideoPlayerController.network(
//         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
//     //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.setLooping(true);
//     _controller.setVolume(1.0);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//
//
//   @override
//   void afterFirstLayout(BuildContext context) => checkFirstSeen();
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("Video Demo"),
//       ),
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Center(
//               child: AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               ),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             if (_controller.value.isPlaying) {
//               _controller.pause();
//             } else {
//               _controller.play();
//             }
//           });
//         },
//         child:
//         Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
//       ),
//     );
//   }
// }