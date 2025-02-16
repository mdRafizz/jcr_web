import 'category.dart';

class Posts {
  
  final int? id;
  final String? title;
  final String? slug;
  final int? categoryId;
  final String? description;
  final String? document;
  final String? convertedDocument;
  final String? image;
  final DateTime? startingDate;
  final DateTime? endingDate;
  final DateTime? publishDate;
  final String? link;
  final int? totalViewed;
  final int? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  Posts({
    this.id,
    this.title,
    this.slug,
    this.categoryId,
    this.description,
    this.document,
    this.convertedDocument,
    this.image,
    this.startingDate,
    this.endingDate,
    this.publishDate,
    this.link,
    this.totalViewed,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'] as int?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      categoryId: json['category_id'] as int?,
      description: json['description'] as String?,
      document: json['docment'] as String?,
      convertedDocument: json['converted_document'] as String?,
      image: json['image'] as String?,
      startingDate: json['starting_date'] != null
          ? DateTime.tryParse(json['starting_date'])
          : null,
      endingDate: json['ending_date'] != null
          ? DateTime.tryParse(json['ending_date'])
          : null,
      publishDate: json['publish_date'] != null
          ? DateTime.tryParse(json['publish_date'])
          : null,
      link: json['link'] as String?,
      totalViewed: json['total_viewed'] as int?,
      type: json['type'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
    );
  }
}

