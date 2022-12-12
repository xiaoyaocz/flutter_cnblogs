import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class BookmarkListItemModel {
  BookmarkListItemModel({
    required this.wzLinkId,
    required this.title,
    required this.linkUrl,
    required this.summary,
    required this.tags,
    required this.dateAdded,
    required this.fromCNBlogs,
  });

  factory BookmarkListItemModel.fromJson(Map<String, dynamic> json) {
    final List<String>? tags = json['Tags'] is List ? <String>[] : null;
    if (tags != null) {
      for (final dynamic item in json['Tags']!) {
        if (item != null) {
          tags.add(asT<String>(item)!);
        }
      }
    }
    return BookmarkListItemModel(
      wzLinkId: asT<int>(json['WzLinkId'])!,
      title: asT<String>(json['Title'])!,
      linkUrl: asT<String>(json['LinkUrl'])!,
      summary: asT<String?>(json['Summary']) ?? "",
      tags: tags!,
      dateAdded: asT<String>(json['DateAdded'])!,
      fromCNBlogs: asT<bool>(json['FromCNBlogs'])!,
    );
  }

  int wzLinkId;
  String title;
  String linkUrl;
  String summary;
  List<String> tags;
  String dateAdded;
  DateTime get addDateTime => DateTime.parse(dateAdded);
  bool fromCNBlogs;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'WzLinkId': wzLinkId,
        'Title': title,
        'LinkUrl': linkUrl,
        'Summary': summary,
        'Tags': tags,
        'DateAdded': dateAdded,
        'FromCNBlogs': fromCNBlogs,
      };
}
