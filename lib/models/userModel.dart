class User {
  String name;
  String email;
  String photourl;

  User({this.name, this.email, this.photourl});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photourl = json['photourl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['photourl'] = this.photourl;
    return data;
  }

  List<String> toStringList() {
    return <String>[name, email, photourl];
  }
}
