import 'package:adv_to_do_app8/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:adv_to_do_app8/view/todo_ui.dart";
import "package:adv_to_do_app8/controller/user_controller.dart";


class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  

  UserController userControllerObj = UserController();

  CustomSnackbar customSnackbarObj = CustomSnackbar();

  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(234, 238, 235, 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: Image.asset(
                                "assets/to_do.jpg",
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "userName",
                              style: GoogleFonts.exo2(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),    
                            ),
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 400,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            maxLength: 10,
                            controller: userNameController,
                            decoration: InputDecoration(
                              hintText: "username",
                              hintStyle: GoogleFonts.exo2(
                               fontSize: 17,
                               fontWeight: FontWeight.w400,
                              ),
                              counterText: "",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: ElevatedButton(
                              onPressed: () async {
                                
                                if(userNameController.text.trim().isNotEmpty){
                                  Map<String, dynamic> data = {
                                  'userName': userNameController.text.trim(),
                                  'loginFlag': true,
                                };
                                await userControllerObj.setSharedPrefData(data);
                                
                                customSnackbarObj.showCustomSnackbar(context, message: "Login Successfully", bgColor: Colors.green);
                                
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return TodoApp();
                                    },
                                  ),
                                );
                                setState(() {});
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(111, 81, 255, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: GoogleFonts.exo2(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
