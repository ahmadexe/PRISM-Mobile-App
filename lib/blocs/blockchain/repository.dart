part of 'bloc.dart';

class _ChainRepo {
  Future<void> postData(List<String> data, String blockchainAddress, String nodeAddress) async {
    try {
      final payload = {
        'data': data,
        'blockchainAddress': blockchainAddress,
      };
      _ChainProvider.postData(payload, nodeAddress);
    } catch (e) {
      rethrow;
    }
  }
}