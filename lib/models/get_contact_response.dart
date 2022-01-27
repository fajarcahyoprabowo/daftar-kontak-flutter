import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'contact.dart';

class GetContactResponse extends Equatable {
  final bool? success;
  final List<Contact>? data;
  final String? message;
  final int? code;

  const GetContactResponse({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory GetContactResponse.fromMap(Map<String, dynamic> data) {
    return GetContactResponse(
      success: data['success'] as bool?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Contact.fromMap(e as Map<String, dynamic>))
          .toList(),
      message: data['message'] as String?,
      code: data['code'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data?.map((e) => e.toMap()).toList(),
        'message': message,
        'code': code,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetContactResponse].
  factory GetContactResponse.fromJson(String data) {
    return GetContactResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetContactResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  GetContactResponse copyWith({
    bool? success,
    List<Contact>? data,
    String? message,
    int? code,
  }) {
    return GetContactResponse(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [success, data, message, code];
}
