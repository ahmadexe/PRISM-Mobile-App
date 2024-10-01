import 'dart:convert';

class Wallet {
  final String publicKey;
  final String privateKey;
  final String blockchainAddress;
  double amount;

  Wallet({
    required this.publicKey,
    required this.privateKey,
    required this.blockchainAddress,
    this.amount = 0,
  });

  Wallet copyWith({
    String? publicKey,
    String? privateKey,
    String? blockchainAddress,
    double? amount,
  }) {
    return Wallet(
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
      blockchainAddress: blockchainAddress ?? this.blockchainAddress,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'publicKey': publicKey,
      'privateKey': privateKey,
      'blockchainAddress': blockchainAddress,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      publicKey: map['publicKey'] as String,
      privateKey: map['privateKey'] as String,
      blockchainAddress: map['blockchainAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Wallet(publicKey: $publicKey, privateKey: $privateKey, blockchainAddress: $blockchainAddress, amount: $amount))';

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;

    return other.publicKey == publicKey &&
        other.privateKey == privateKey &&
        other.blockchainAddress == blockchainAddress &&
        other.amount == amount;
  }

  @override
  int get hashCode =>
      publicKey.hashCode ^
      privateKey.hashCode ^
      blockchainAddress.hashCode ^
      amount.hashCode;
}
