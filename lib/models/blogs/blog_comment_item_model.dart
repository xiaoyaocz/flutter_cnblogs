import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class BlogCommentItemModel {
  BlogCommentItemModel({
    required this.id,
    required this.body,
    required this.author,
    required this.authorUrl,
    required this.faceUrl,
    required this.floor,
    required this.dateAdded,
  });

  factory BlogCommentItemModel.fromJson(Map<String, dynamic> json) =>
      BlogCommentItemModel(
        id: asT<int?>(json['Id']) ?? 0,
        body: asT<String?>(json['Body']) ?? "",
        author: asT<String?>(json['Author']) ?? "",
        authorUrl: asT<String?>(json['AuthorUrl']) ?? "",
        faceUrl: asT<String?>(json['FaceUrl']) ?? "",
        floor: asT<int?>(json['Floor']) ?? 0,
        dateAdded: asT<String?>(json['DateAdded']) ?? "",
      );

  int id;
  String body;
  String author;
  String authorUrl;
  String faceUrl;
  int floor;
  String dateAdded;
  DateTime get postDateTime => DateTime.parse(dateAdded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Body': body,
        'Author': author,
        'AuthorUrl': authorUrl,
        'FaceUrl': faceUrl,
        'Floor': floor,
        'DateAdded': dateAdded,
      };
}
