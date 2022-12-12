import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class KnowledgeListItemModel {
  KnowledgeListItemModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.author,
    required this.viewcount,
    required this.diggcount,
    required this.dateadded,
  });

  factory KnowledgeListItemModel.fromJson(Map<String, dynamic> json) =>
      KnowledgeListItemModel(
        id: asT<int>(json['Id'])!,
        title: asT<String>(json['Title'])!,
        summary: asT<String>(json['Summary'])!,
        author: asT<String?>(json['Author']) ?? "",
        viewcount: asT<int>(json['ViewCount'])!,
        diggcount: asT<int>(json['DiggCount'])!,
        dateadded: asT<String>(json['DateAdded'])!,
      );

  int id;
  String title;
  String summary;
  String author;
  int viewcount;
  int diggcount;
  String dateadded;
  DateTime get postDateTime => DateTime.parse(dateadded);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Title': title,
        'Summary': summary,
        'Author': author,
        'ViewCount': viewcount,
        'DiggCount': diggcount,
        'DateAdded': dateadded,
      };
}
