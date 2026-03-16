import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:adv_to_do_app8/todo_ui.dart";
import "package:adv_to_do_app8/user_controller.dart";

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  //initState
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  UserController userControllerObj = UserController();

  getUserName() async {
    await userControllerObj.getSharedPrefData();

    if (userControllerObj.userLogged) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return TodoApp();
          },
        ),
      );
    } else {}
  }

  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
        
              // Center(
              //   child: Image.asset(
              //     "assets/to_do.jpg",
              //     height: 150,
              //     width: 150,
              //     fit: BoxFit.cover,
              //   ),
              // ),
        
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("assets/to_do.jpg"),
                  backgroundColor: Colors.transparent,
                ),
              ),
        
              SizedBox(height: 200),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("UserName", style: GoogleFonts.quicksand(fontSize:20, fontWeight: FontWeight.w400, color: Colors.black)),
                ],
              ),
              Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
        
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: "Enter your first name, eg- Yash",
                    hintStyle: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, )
                  ),
                  
                ),
              ),
        
              SizedBox(height: 40),
        
              //Button
              Center(
                child: SizedBox(
                  height: 50,
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        'userName': userNameController.text.trim(),
                        'loginFlag': true,
                      };
                      await userControllerObj.setSharedPrefData(data);
                      setState(() {
                        
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return TodoApp();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
        
                    child: Text(
                      "Login",
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
