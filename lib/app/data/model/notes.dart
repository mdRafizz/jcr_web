import 'package:job_circular2/app/data/model/subject.dart';

class Notes {
  int? id;
  String? title;
  String? slug;
  int? subjectCategoryId;
  String? description;
  String? document;
  int? totalViewed;
  DateTime? createdAt;
  DateTime? updatedAt;
  SubjectCategory? subjectCategory;

  Notes({
    this.id,
    this.title,
    this.slug,
    this.subjectCategoryId,
    this.description,
    this.document,
    this.totalViewed,
    this.createdAt,
    this.updatedAt,
    this.subjectCategory,
  });


  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
    id: json['id'],
    title: json['title'],
    slug: json['slug'],
    subjectCategoryId: json['subject_category_id'],
    description: json['description'],
    document: json['document'],
    totalViewed: json['total_viewed'],
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    subjectCategory: json['subject_category'] != null ? SubjectCategory.fromJson(json['subject_category']) : null,
  );

}
