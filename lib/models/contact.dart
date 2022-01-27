import 'dart:convert';

import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String? contactId;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? notes;
  final List<String>? labels;
  final String? creator;
  final String? createdAt;
  final String? updatedAt;

  const Contact({
    this.contactId,
    this.name,
    this.email,
    this.phoneNumber,
    this.notes,
    this.labels,
    this.creator,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromMap(Map<String, dynamic> data) => Contact(
        contactId: data['contactId'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phoneNumber: data['phoneNumber'] as String?,
        notes: data['notes'] as String?,
        labels: (data['labels'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        creator: data['creator'] as String?,
        createdAt: data['createdAt'] as String?,
        updatedAt: data['updatedAt'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'contactId': contactId,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'notes': notes,
        'labels': labels,
        'creator': creator,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Contact].
  factory Contact.fromJson(String data) {
    return Contact.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Contact] to a JSON string.
  String toJson() => json.encode(toMap());

  Contact copyWith({
    String? contactId,
    String? name,
    String? email,
    String? phoneNumber,
    String? notes,
    List<String>? labels,
    String? creator,
    String? createdAt,
    String? updatedAt,
  }) {
    return Contact(
      contactId: contactId ?? this.contactId,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      notes: notes ?? this.notes,
      labels: labels ?? this.labels,
      creator: creator ?? this.creator,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      contactId,
      name,
      email,
      phoneNumber,
      notes,
      labels,
      creator,
      createdAt,
      updatedAt,
    ];
  }
}
