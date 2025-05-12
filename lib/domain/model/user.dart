class Users {
  List<User> data = [];

  Users({required this.data});

  Users.fromJson(List<Map<String, dynamic>> json) {
    for (int i = 0; i < json.length; i++) {
      data.add(User.fromJson(json[i]));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? firstname;
  String? lastname;
  String? email;
  String? phonenumber;
  String? password;
  String? id;

  User({
    this.firstname,
    this.lastname,
    this.email,
    this.phonenumber,
    this.password,
    this.id,
  });

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    password = json['password'];
    id = json['id'];
  }

  User copyWith(
    String? firstname,
    String? lastname,
    String? email,
    String? phonenumber,
    String? id,
    String? password,
  ) {
    return User(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phonenumber: phonenumber ?? this.phonenumber,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}
