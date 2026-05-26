import "package:adv_to_do_app8/widget/custom_snackbar.dart";
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "package:adv_to_do_app8/model/todo_model.dart";
import "package:intl/intl.dart";
import "package:adv_to_do_app8/model/database.dart";
import "package:adv_to_do_app8/controller/user_controller.dart";

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  //todoCardsList Data
  List<ToDoModel> todoCardsList = [];

  //custom snackbar
  CustomSnackbar customSnackbarObj = CustomSnackbar();

  //initState()
  @override
  void initState() {
    super.initState();
    getData();
    time();
    getUserData();
  }

  //data coming from sqfLite dataBase
  void getData() async {
    List<Map> cardList = await TodoDatabase().getTodoItems();

    for (var element in cardList) {
      todoCardsList.add(
        ToDoModel(
          date: element['date'],
          description: element['description'],
          title: element['title'],
          id: element['id'],
        ),
      );
    }

    setState(() {});
  }

  //time method getting hour for checking moons
  String time() {
    String hour;
    num hourIs = DateTime.now().hour;

    if (hourIs >= 5 && hourIs < 12) {
      hour = "Good Morning";
    } else if (hourIs >= 12 && hourIs < 18) {
      hour = "Good Afternoon";
    } else {
      hour = "Good Evening";
    }
    return hour;
  }

  //getUserData
  void getUserData() async {
    await userObj.getSharedPrefData();
    setState(() {});
  }

  //ColorList
  List cardColorsList = [
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(250, 249, 232, 1),
    Color.fromRGBO(250, 232, 250, 1),
  ];

  //TextEditingController Call
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //clear Data
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  //Submit Button Logic
  void submit(bool doEdit, [ToDoModel? obj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (doEdit) {
        obj!.title = titleController.text.trim();
        obj.description = descriptionController.text.trim();
        obj.date = dateController.text.trim();

        Map<String, dynamic> mapObj = {
          'title': obj.title,
          'description': obj.description,
          'date': obj.date,
          'id': obj.id,
        };
        TodoDatabase().updateTodoItem(mapObj);

        customSnackbarObj.showCustomSnackbar(
          context,
          message: "Edit Card Successfully",
          bgColor: Colors.green,
        );
      } else {
        todoCardsList.add(
          ToDoModel(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            date: dateController.text.trim(),
          ),
        );

        Map<String, dynamic> dataMap = {
          'title': titleController.text.trim(),
          'date': dateController.text.trim(),
          'description': descriptionController.text.trim(),
        };

        TodoDatabase().insertTodoItem(dataMap);

        customSnackbarObj.showCustomSnackbar(
          context,
          message: "Add Card Successfully",
          bgColor: Colors.green,
        );
      }

      clearController();
      setState(() {});
      Navigator.of(context).pop();
    } //else {
    //   clearController();
    //   setState(() {});

    // }
  }

  //BottomSheet
  showBottomSheet(bool doEdit, [ToDoModel? obj]) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Create To-Do",
                    style: GoogleFonts.quicksand(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //Title
                Text(
                  "title",
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(111, 81, 255, 1),
                  ),
                ),

                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(111, 81, 255, 1),
                        ),
                      ),
                      hintText: "title",
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //Description
                Text(
                  "description",
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(111, 81, 255, 1),
                  ),
                ),

                SizedBox(
                  height: 70,
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(111, 81, 255, 1),
                        ),
                      ),
                      hintText: "description",
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //Date
                Text(
                  "date",
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(111, 81, 255, 1),
                  ),
                ),

                SizedBox(
                  height: 50,
                  child: TextField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(111, 81, 255, 1),
                        ),
                      ),
                      hintText: "date",
                      suffixIcon: Icon(Icons.calendar_month_outlined),
                    ),

                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2026),
                        lastDate: DateTime(2028),
                      );

                      dateController.text = DateFormat.yMMMd().format(
                        pickedDate!,
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                //Button
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        if (doEdit) {
                          submit(true, obj);
                        } else {
                          submit(false);
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: Text(
                        "Add Card",
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteCardAlertDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Notice",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          content: Text(
            "Are you sure you want to delete this card?",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                int id = todoCardsList[index].id;

                todoCardsList.removeAt(index);
                TodoDatabase().deleteTodoItem(id);

                customSnackbarObj.showCustomSnackbar(context, message: "Delete card successfully", bgColor: Colors.green);
                
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text(
                "Delete",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  UserController userObj = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(111, 81, 255, 1),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 60),
                child: Text.rich(
                  TextSpan(
                    text: time(),
                    style: GoogleFonts.quicksand(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    children: [
                      TextSpan(
                        text: "\n${userObj.userName}",
                        style: GoogleFonts.quicksand(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 30),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "CREATE TO DO LIST",
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),

                  SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),

                      child: ListView.builder(
                        itemCount: todoCardsList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    cardColorsList[index %
                                        cardColorsList.length],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            child: Image.asset(
                                              "assets/to_do_logo.jpeg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 10),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                todoCardsList[index].title,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF000000),
                                                ),
                                              ),

                                              SizedBox(height: 10),

                                              Text(
                                                todoCardsList[index]
                                                    .description,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      children: [
                                        Text(
                                          todoCardsList[index].date,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF848484),
                                          ),
                                        ),

                                        Spacer(),

                                        GestureDetector(
                                          onTap: () {
                                            titleController.text =
                                                todoCardsList[index].title;
                                            descriptionController.text =
                                                todoCardsList[index]
                                                    .description;
                                            dateController.text =
                                                todoCardsList[index].date;

                                            showBottomSheet(
                                              true,
                                              todoCardsList[index],
                                            );
                                          },
                                          child: Icon(Icons.edit_outlined),
                                        ),

                                        SizedBox(width: 10),

                                        GestureDetector(
                                          onTap: () {
                                            showDeleteCardAlertDialog(index);
                                          },
                                          child: Icon(
                                            Icons.delete_outline_rounded,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Color.fromRGBO(111, 81, 255, 1),
          shape: CircleBorder(),
          onPressed: () {
            clearController();
            showBottomSheet(false);
          },

          child: Icon(Icons.add_outlined, size: 60, color: Colors.white),
        ),
      ),
    );
  }
}
