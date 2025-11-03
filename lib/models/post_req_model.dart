class PostsReqModel {
  String? userId;
  String? title;

  PostsReqModel({this.title, this.userId});

  PostsReqModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userId'] = this.userId;
    data['title'] = this.title;
    return data;
  }
}
