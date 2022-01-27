import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:assestment_telkom_fajar/commons/common_strings.dart';
import 'package:assestment_telkom_fajar/models/contact.dart';
import 'package:assestment_telkom_fajar/models/get_contact_response.dart';
import 'package:assestment_telkom_fajar/utils/error_handlers.dart';
import 'package:http/http.dart' as http;

class ContactRepo {
  static const int _requestTimeoutLimit = 20;

  static Map<String, String> _headerRequest() {
    return {
      'Accept': 'application/json',
      "Content-Type": "application/json",
      'authorization': "Basic " +
          base64Encode(
            utf8.encode(
              '${CommonStrings.userAuth}:${CommonStrings.passAuth}',
            ),
          ),
    };
  }

  static Future<GetContactResponse> getContact({
    String search = "",
  }) async {
    try {
      String url = "${CommonStrings.baseUrl}/contact";
      url += "?userId=${CommonStrings.userId}";
      url += "&search=$search";

      var response = await http
          .get(
            Uri.parse(url),
            headers: _headerRequest(),
          )
          .timeout(
            const Duration(seconds: _requestTimeoutLimit),
          );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return GetContactResponse.fromMap(responseBody);
      }

      throw Exceptions.UnknownException;
    } on TimeoutException catch (_) {
      throw Exceptions.RequestTimeoutException;
    } on SocketException catch (_) {
      throw Exceptions.NoInternetException;
    } on HttpException {
      throw Exceptions.NoServiceFoundException;
    } on FormatException {
      throw Exceptions.InvalidFormatException;
    } catch (e) {
      print(e);
      throw Exceptions.UnknownException;
    }
  }

  static Future<bool> addContact({
    required Contact contact,
  }) async {
    try {
      String url = "${CommonStrings.baseUrl}/contact";

      var response = await http
          .post(
            Uri.parse(url),
            headers: _headerRequest(),
            body: jsonEncode({
              'name': contact.name,
              'email': contact.email,
              'phoneNumber': contact.phoneNumber,
              'notes': contact.notes,
              'labels': contact.labels,
              'userId': CommonStrings.userId,
            }),
          )
          .timeout(
            const Duration(seconds: _requestTimeoutLimit),
          );

      print("${response.statusCode} POST : $url");
      inspect(response.body);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['success'] as bool;
      }

      throw Exceptions.UnknownException;
    } on TimeoutException catch (_) {
      throw Exceptions.RequestTimeoutException;
    } on SocketException catch (_) {
      throw Exceptions.NoInternetException;
    } on HttpException {
      throw Exceptions.NoServiceFoundException;
    } on FormatException {
      throw Exceptions.InvalidFormatException;
    } catch (e) {
      print(e);
      throw Exceptions.UnknownException;
    }
  }

  static Future<bool> updateContact({
    required Contact contact,
  }) async {
    try {
      String url = "${CommonStrings.baseUrl}/contact";
      url += "/${contact.contactId}";

      var response = await http
          .put(
            Uri.parse(url),
            headers: _headerRequest(),
            body: jsonEncode({
              'name': contact.name,
              'email': contact.email,
              'phoneNumber': contact.phoneNumber,
              'notes': contact.notes,
              'labels': contact.labels,
              'userId': CommonStrings.userId,
            }),
          )
          .timeout(
            const Duration(seconds: _requestTimeoutLimit),
          );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['success'] as bool;
      }

      throw Exceptions.UnknownException;
    } on TimeoutException catch (_) {
      throw Exceptions.RequestTimeoutException;
    } on SocketException catch (_) {
      throw Exceptions.NoInternetException;
    } on HttpException {
      throw Exceptions.NoServiceFoundException;
    } on FormatException {
      throw Exceptions.InvalidFormatException;
    } catch (e) {
      print(e);
      throw Exceptions.UnknownException;
    }
  }

  static Future<bool> deleteContact({
    required Contact contact,
  }) async {
    try {
      String url = "${CommonStrings.baseUrl}/contact";
      url += "/${contact.contactId}";

      var response = await http
          .delete(
            Uri.parse(url),
            headers: _headerRequest(),
            body: jsonEncode({
              'userId': CommonStrings.userId,
            }),
          )
          .timeout(
            const Duration(seconds: _requestTimeoutLimit),
          );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody['success'] as bool;
      }

      throw Exceptions.UnknownException;
    } on TimeoutException catch (_) {
      throw Exceptions.RequestTimeoutException;
    } on SocketException catch (_) {
      throw Exceptions.NoInternetException;
    } on HttpException {
      throw Exceptions.NoServiceFoundException;
    } on FormatException {
      throw Exceptions.InvalidFormatException;
    } catch (e) {
      print(e);
      throw Exceptions.UnknownException;
    }
  }
}
