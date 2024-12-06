import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MediaUtils {
  static Future<Uint8List?> getImageBytes(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        debugPrint(
            "Error: Failed to load image with status code ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }
}
