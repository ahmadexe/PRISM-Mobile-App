import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<bool> makePayment(int amount) async {
    try {
      final clientSecret = await _createPaymentIntent(amount, 'usd');
      if (clientSecret == null) return false;

      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "PRISM",
        style: ThemeMode.dark,
      ));

      final ok = await _processPayment();
      return ok;
    } catch (e) {
      debugPrint('----- ERROR in Stripe Service -----');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<String?> _createPaymentIntent(int value, String currency) async {
    try { 
      final client = Dio();
      final data = {
        'amount': (value * 100).toString(),
        'currency': currency,
      };
      
      final secretKey = dotenv.env['STRIPE_SECRET_KEY'];
      if (secretKey == null || secretKey.isEmpty) {
        throw Exception('Stripe secret key not found');
      }

      final res = await client.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          }
        )
      );

      if (res.data != null) {
        return res.data['client_secret'];
      }

      return null;

    } catch (e) {
      debugPrint('----- ERROR in Stripe Service -----');
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } catch (e) {
      debugPrint('----- ERROR in Stripe Service -----');
      debugPrint(e.toString());
      return false;
    }
  }
}