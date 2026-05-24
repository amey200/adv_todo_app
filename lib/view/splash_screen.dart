import 'package:adv_to_do_app8/view/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_to_do_app8/controller/user_controller.dart';
import 'package:adv_to_do_app8/view/todo_ui.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //initState
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  UserController userControllerObj = UserController();

  getUserName() async {
    await Future.delayed(Duration(seconds: 2), () async {
      await userControllerObj.getSharedPrefData();

      if (userControllerObj.userLogged) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return TodoApp();
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return UserLoginScreen();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset("assets/to_do.jpg", height: 150, width: 150),
            ),
          ),

          Text("To Do App", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(0, 0, 0, 1))),
        
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}
