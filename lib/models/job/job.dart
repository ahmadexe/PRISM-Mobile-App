import 'dart:convert';

import 'package:flutter/foundation.dart';

class Job {
  final String postedBy;
  final String title;
  final String description;
  final DateTime postedAt;
  final String country;
  final List<String> keywords;
  final List<String> likedBy;
  final List<String> appliedBy;
  final bool isAvailable;
  final String hiredBy;
  final DateTime hiredAt;
  final String id;
  final double budget;
  final String budgetMeta;

  Job({
    required this.postedBy,
    required this.title,
    required this.description,
    required this.postedAt,
    required this.country,
    required this.keywords,
    required this.likedBy,
    required this.appliedBy,
    required this.isAvailable,
    required this.hiredBy,
    required this.hiredAt,
    required this.id,
    required this.budget,
    required this.budgetMeta,
  });

  Job copyWith({
    String? postedBy,
    String? title,
    String? description,
    DateTime? postedAt,
    String? country,
    List<String>? keywords,
    List<String>? likedBy,
    List<String>? appliedBy,
    bool? isAvailable,
    String? hiredBy,
    DateTime? hiredAt,
    String? id,
    double? budget,
    String? budgetMeta,
  }) {
    return Job(
      postedBy: postedBy ?? this.postedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      postedAt: postedAt ?? this.postedAt,
      country: country ?? this.country,
      keywords: keywords ?? this.keywords,
      likedBy: likedBy ?? this.likedBy,
      appliedBy: appliedBy ?? this.appliedBy,
      isAvailable: isAvailable ?? this.isAvailable,
      hiredBy: hiredBy ?? this.hiredBy,
      hiredAt: hiredAt ?? this.hiredAt,
      id: id ?? this.id,
      budget: budget ?? this.budget,
      budgetMeta: budgetMeta ?? this.budgetMeta,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postedBy': postedBy,
      'title': title,
      'description': description,
      'postedAt': postedAt.millisecondsSinceEpoch,
      'country': country,
      'keywords': keywords,
      'likedBy': likedBy,
      'appliedBy': appliedBy,
      'isAvailable': isAvailable,
      'hiredBy': hiredBy,
      'hiredAt': hiredAt.millisecondsSinceEpoch,
      'id': id,
      'budget': budget,
      'budgetMeta': budgetMeta,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      postedBy: map['postedBy'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      postedAt: DateTime.fromMillisecondsSinceEpoch(map['postedAt'] as int),
      country: map['country'] as String,
      keywords: List<String>.from((map['keywords'] as List<dynamic>)),
      likedBy: List<String>.from((map['likedBy'] as List<dynamic>)),
      appliedBy: List<String>.from((map['appliedBy'] as List<dynamic>)),
      isAvailable: map['isAvailable'] as bool,
      hiredBy: map['hiredBy'] as String,
      hiredAt: DateTime.fromMillisecondsSinceEpoch(map['hiredAt'] as int),
      id: map['id'] as String,
      budget: map['budget'] as double,
      budgetMeta: map['budgetMeta'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) =>
      Job.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Job(postedBy: $postedBy, title: $title, description: $description, postedAt: $postedAt, country: $country, keywords: $keywords, likedBy: $likedBy, appliedBy: $appliedBy, isAvailable: $isAvailable, hiredBy: $hiredBy, hiredAt: $hiredAt, id: $id, budget: $budget, budgetMeta: $budgetMeta)';
  }

  @override
  bool operator ==(covariant Job other) {
    if (identical(this, other)) return true;

    return other.postedBy == postedBy &&
        other.title == title &&
        other.description == description &&
        other.postedAt == postedAt &&
        other.country == country &&
        listEquals(other.keywords, keywords) &&
        listEquals(other.likedBy, likedBy) &&
        listEquals(other.appliedBy, appliedBy) &&
        other.isAvailable == isAvailable &&
        other.hiredBy == hiredBy &&
        other.hiredAt == hiredAt &&
        other.id == id &&
        other.budget == budget &&
        other.budgetMeta == budgetMeta;
  }

  @override
  int get hashCode {
    return postedBy.hashCode ^
        title.hashCode ^
        description.hashCode ^
        postedAt.hashCode ^
        country.hashCode ^
        keywords.hashCode ^
        likedBy.hashCode ^
        appliedBy.hashCode ^
        isAvailable.hashCode ^
        hiredBy.hashCode ^
        hiredAt.hashCode ^
        id.hashCode ^
        budget.hashCode ^
        budgetMeta.hashCode;
  }
}
