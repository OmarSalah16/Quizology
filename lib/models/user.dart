class Users {
  late String? email;
  late String uid;
  late String firstName;
  late String lastName;
  late List<dynamic> favorites = [];
  late int currentcategory;
  Users({
    this.firstName = "",
    this.lastName = "",
    this.uid = "",
    this.currentcategory = 0,
  });
  Map<String, dynamic> toMap(Users user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["firstname"] = user.firstName;
    data['lastName'] = user.lastName;
    data["email"] = user.email;
    data["favorites"] = [];
    return data;
  }
}
