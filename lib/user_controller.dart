
import "package:shared_preferences/shared_preferences.dart";

class UserController {

  String  userName = "";
  bool userLogged = false;

  //set Data
  Future<void> setSharedPrefData (Map<String , dynamic> obj) async{
    SharedPreferences sharedPreferencesObj = await SharedPreferences.getInstance();

    await sharedPreferencesObj.setString("userName", obj['userName']);
    await sharedPreferencesObj.setBool("userLogged", obj['loginFlag']);
  }

  //get Data
  Future<void> getSharedPrefData () async{
    SharedPreferences sharedPreferencesObj = await SharedPreferences.getInstance();

    userName = sharedPreferencesObj.getString("userName") ?? "";
    userLogged = sharedPreferencesObj.getBool("userLogged") ?? false;
    
  }

}