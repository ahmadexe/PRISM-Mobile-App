import 'dart:convert';

import 'package:flutter/foundation.dart';

class DataModel {
  final List<String> data;
  final String blockchainAddress;
  DataModel({
    required this.data,
    required this.blockchainAddress,
  });

  DataModel copyWith({
    List<String>? data,
    String? blockchainAddress,
  }) {
    return DataModel(
      data: data ?? this.data,
      blockchainAddress: blockchainAddress ?? this.blockchainAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'blockchainAddress': blockchainAddress,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      data: List<String>.from((map['data'] as List)),
      blockchainAddress: map['blockchainAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DataModel(data: $data, blockchainAddress: $blockchainAddress)';

  @override
  bool operator ==(covariant DataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) &&
        other.blockchainAddress == blockchainAddress;
  }

  @override
  int get hashCode => data.hashCode ^ blockchainAddress.hashCode;
}
