class CardModel {
  String title;
  String subtitle;
  String time;
  String category;
  String headline;
  String image;

  CardModel(
      {this.headline,
      this.title,
      this.subtitle,
      this.time,
      this.category,
      this.image});

  CardModel.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    title = json['title'];
    subtitle = json['subtitle'];
    time = json['time'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headline'] = this.headline;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['time'] = this.time;
    data['category'] = this.category;
    data['image'] = this.image;
    return data;
  }
}
