import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/fire_store_services.dart';

class UserProvider with ChangeNotifier {
  Users _user = Users();
  late FireStoreServices instance = FireStoreServices();
  Users get getUser {
    return _user;
  }

  readUser() async {
    var data = await instance.readUser();
    _user.firstName = data['firstname'];
    _user.lastName = data['lastName'];
    _user.uid = data['uid'];
    _user.favorites = data["favorites"];
    notifyListeners();
  }
}
