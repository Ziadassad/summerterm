import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st/models/Account.dart';

class AccountManagement extends ChangeNotifier{

  String USER_ID = "USER_ID";
  String LOGIN = "LOGIN";


  Account? _account;

  String? _user_id = "";
  bool? _isLogin = false;


  AccountManagement(){
    getAccount();
    notifyListeners();
  }


  Account? get account => _account;

  String? get user_id => _user_id;

  bool? get isLogin => _isLogin;


  setAccount(Account? account){
    _account = account;
    notifyListeners();
  }


  Future<String?> getAccount() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    _user_id = sharedPreferences.getString(USER_ID);
    _isLogin = sharedPreferences.getBool(LOGIN) ?? false;

    notifyListeners();

    return sharedPreferences.getString(USER_ID);
  }

  setLoginAccount(String idUser) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USER_ID, idUser);
    sharedPreferences.setBool(LOGIN, true);
    _user_id = idUser;
    _isLogin = true;
    notifyListeners();
  }

  setLogoutAccount() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(LOGIN, false);
    _isLogin = false;
    notifyListeners();
  }

}