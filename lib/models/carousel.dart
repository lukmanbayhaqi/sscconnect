class Carousel {
  String? id;
  String? image;

  Carousel({
    this.id,
    this.image,
  });

  Carousel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['image'] = image;

    return data;
  }
}
