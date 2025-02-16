class SubjectCategory {
  
  int? id;
  String? name;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubjectCategory({
     this.id,
     this.name,
     this.slug,
     this.createdAt,
     this.updatedAt,
  });

  factory SubjectCategory.fromJson(Map<String, dynamic> json) => SubjectCategory(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );
}
