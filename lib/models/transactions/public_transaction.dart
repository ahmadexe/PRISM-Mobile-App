import 'dart:convert';

class PublicTransaction {
  final String recipientChainAddress;
  final String senderChainAddress;
  final double value;

  PublicTransaction({
    required this.recipientChainAddress,
    required this.senderChainAddress,
    required this.value,
  });


  PublicTransaction copyWith({
    String? recipientChainAddress,
    String? senderChainAddress,
    double? value,
  }) {
    return PublicTransaction(
      recipientChainAddress: recipientChainAddress ?? this.recipientChainAddress,
      senderChainAddress: senderChainAddress ?? this.senderChainAddress,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipientChainAddress': recipientChainAddress,
      'senderChainAddress': senderChainAddress,
      'value': value,
    };
  }

  factory PublicTransaction.fromMap(Map<String, dynamic> map) {
    return PublicTransaction(
      recipientChainAddress: map['recipientChainAddress'] as String,
      senderChainAddress: map['senderChainAddress'] as String,
      value: double.parse(map['value'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory PublicTransaction.fromJson(String source) => PublicTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PublicTransaction(recipientChainAddress: $recipientChainAddress, senderChainAddress: $senderChainAddress, value: $value)';

  @override
  bool operator ==(covariant PublicTransaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.recipientChainAddress == recipientChainAddress &&
      other.senderChainAddress == senderChainAddress &&
      other.value == value;
  }

  @override
  int get hashCode => recipientChainAddress.hashCode ^ senderChainAddress.hashCode ^ value.hashCode;
}
