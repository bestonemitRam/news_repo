class DashBoardModel {
   String? id;
  dynamic description;
  dynamic heading;
  dynamic img;
  dynamic news_id;
  dynamic news_link;
  dynamic title;
  dynamic video;
 

  DashBoardModel(
      { this.id,
        this.description,
      this.heading,
      this.img,
      this.news_id,
      this.news_link,
      this.title,
      this.video
      });




  factory DashBoardModel.fromMap(Map<dynamic, dynamic> data) {
    return DashBoardModel(
      id: data['id'],
      description: data['description'],
      heading: data['heading'],
      img: data['img'],
      news_id: data['news_id'],
      news_link: data['news_link'],
      title: data['title'],
      video: data['video'],
    );
  }
    factory DashBoardModel.fromJson(Map<String, dynamic> json) {
    return DashBoardModel(
      id: json['id'],
      description: json['description'],
      heading: json['heading'],
      img: json['img'],
      news_id: json['news_id'],
      news_link: json['news_link'],
      title: json['title'],
      video: json['video'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'heading': heading,
      'img': img,
      'news_id': news_id,
      'news_link': news_link,
      'title': title,
      'video': video,
    };
  }

}
