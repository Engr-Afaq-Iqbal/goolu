// To parse this JSON data, do
//
//     final stripePaymentRecord = stripePaymentRecordFromJson(jsonString);

import 'dart:convert';

StripePaymentRecord stripePaymentRecordFromJson(String str) =>
    StripePaymentRecord.fromJson(json.decode(str));

String stripePaymentRecordToJson(StripePaymentRecord data) =>
    json.encode(data.toJson());

class StripePaymentRecord {
  String? id;
  int? amount;
  String? created;
  String? currency;
  String? status;
  String? clientSecret;
  bool? livemode;
  String? captureMethod;
  String? confirmationMethod;
  String? paymentMethodId;
  dynamic description;
  dynamic receiptEmail;
  String? canceledAt;
  dynamic nextAction;
  dynamic shipping;
  dynamic mandateData;
  dynamic latestCharge;

  StripePaymentRecord({
    this.id,
    this.amount,
    this.created,
    this.currency,
    this.status,
    this.clientSecret,
    this.livemode,
    this.captureMethod,
    this.confirmationMethod,
    this.paymentMethodId,
    this.description,
    this.receiptEmail,
    this.canceledAt,
    this.nextAction,
    this.shipping,
    this.mandateData,
    this.latestCharge,
  });

  factory StripePaymentRecord.fromJson(Map<String, dynamic> json) =>
      StripePaymentRecord(
        id: json["id"],
        amount: json["amount"],
        created: json["created"],
        currency: json["currency"],
        status: json["status"],
        clientSecret: json["clientSecret"],
        livemode: json["livemode"],
        captureMethod: json["captureMethod"],
        confirmationMethod: json["confirmationMethod"],
        paymentMethodId: json["paymentMethodId"],
        description: json["description"],
        receiptEmail: json["receiptEmail"],
        canceledAt: json["canceledAt"],
        nextAction: json["nextAction"],
        shipping: json["shipping"],
        mandateData: json["mandateData"],
        latestCharge: json["latestCharge"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "created": created,
        "currency": currency,
        "status": status,
        "clientSecret": clientSecret,
        "livemode": livemode,
        "captureMethod": captureMethod,
        "confirmationMethod": confirmationMethod,
        "paymentMethodId": paymentMethodId,
        "description": description,
        "receiptEmail": receiptEmail,
        "canceledAt": canceledAt,
        "nextAction": nextAction,
        "shipping": shipping,
        "mandateData": mandateData,
        "latestCharge": latestCharge,
      };
}
