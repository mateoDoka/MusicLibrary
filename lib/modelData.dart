class MyData {
  final String link;
  final String name;
  final String title;
  final String image;
  MyData({
    required this.link,
    required this.name,
    required this.title,
    required this.image,
  });

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      link: json['link'] ?? '',
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'link': link, 'name': name, 'title': title, 'image': image};
  }
}
