import 'dart:convert';

class Transaction {
  final String senderPublicKey;
  final String senderPrivateKey;
  final String senderBlockchainAddress;
  final String recipientBlockchainAddress;
  final double value;

  Transaction({
    required this.senderPublicKey,
    required this.senderPrivateKey,
    required this.senderBlockchainAddress,
    required this.recipientBlockchainAddress,
    required this.value,
  });

  Transaction copyWith({
    String? senderPublicKey,
    String? senderPrivateKey,
    String? senderBlockchainAddress,
    String? recipientBlockchainAddress,
    double? value,
  }) {
    return Transaction(
      senderPublicKey: senderPublicKey ?? this.senderPublicKey,
      senderPrivateKey: senderPrivateKey ?? this.senderPrivateKey,
      senderBlockchainAddress: senderBlockchainAddress ?? this.senderBlockchainAddress,
      recipientBlockchainAddress: recipientBlockchainAddress ?? this.recipientBlockchainAddress,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderPublicKey': senderPublicKey,
      'senderPrivateKey': senderPrivateKey,
      'senderBlockchainAddress': senderBlockchainAddress,
      'recipientBlockchainAddress': recipientBlockchainAddress,
      'value': value,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      senderPublicKey: map['senderPublicKey'] as String,
      senderPrivateKey: map['senderPrivateKey'] as String,
      senderBlockchainAddress: map['senderBlockchainAddress'] as String,
      recipientBlockchainAddress: map['recipientBlockchainAddress'] as String,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(senderPublicKey: $senderPublicKey, senderPrivateKey: $senderPrivateKey, senderBlockchainAddress: $senderBlockchainAddress, recipientBlockchainAddress: $recipientBlockchainAddress, value: $value)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.senderPublicKey == senderPublicKey &&
      other.senderPrivateKey == senderPrivateKey &&
      other.senderBlockchainAddress == senderBlockchainAddress &&
      other.recipientBlockchainAddress == recipientBlockchainAddress &&
      other.value == value;
  }

  @override
  int get hashCode {
    return senderPublicKey.hashCode ^
      senderPrivateKey.hashCode ^
      senderBlockchainAddress.hashCode ^
      recipientBlockchainAddress.hashCode ^
      value.hashCode;
  }
}
