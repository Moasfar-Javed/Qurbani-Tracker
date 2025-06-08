part of 'models.dart';

class QurbaniModel {
  String identifier;
  String title;
  String currency;
  bool includeTimestamps;
  bool onGoing;
  final DateTime createdOn;
  DateTime updatedOn;
  bool isLocal;
  List<String> shareholders;

  QurbaniModel({
    required this.identifier,
    required this.title,
    required this.currency,
    required this.includeTimestamps,
    required this.onGoing,
    required this.createdOn,
    required this.updatedOn,
    required this.shareholders,
    this.isLocal = false,
  });

  factory QurbaniModel.fromJson(Map<String, dynamic> json, String docId) {
    return QurbaniModel(
      identifier: docId,
      title: json['title'],
      currency: json['currency'],
      includeTimestamps: json['includeTimestamps'],
      onGoing: json['onGoing'],
      createdOn: DateTime.parse(json['createdOn']),
      updatedOn: DateTime.parse(json['updatedOn']),
      shareholders: json['shareholders'] as List<String>,
      isLocal: json['isLocal'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'currency': currency,
      'includeTimestamps': includeTimestamps,
      'onGoing': onGoing,
      'shareholders': shareholders,
      'createdOn': createdOn.toUtc().toIso8601String(),
      'updatedOn': updatedOn.toUtc().toIso8601String(),
      'isLocal': isLocal,
    };
  }
}

abstract class Spending {
   String identifier;
   String qurbaniIdentifier;
   String notes;
   num amount;
   DateTime createdOn;
   DateTime updatedOn;
  bool isLocal;

  Spending({
    required this.identifier,
    required this.qurbaniIdentifier,
    required this.notes,
    required this.amount,
    required this.createdOn,
    required this.updatedOn,
    required this.isLocal,
  });
}

class ExpenseModel extends Spending {
   String category;

  ExpenseModel({
    required super.identifier,
    required super.qurbaniIdentifier,
    required super.notes,
    required super.amount,
    required super.createdOn,
    required super.updatedOn,
    required this.category,
    super.isLocal = false,
  });

  factory ExpenseModel.fromJson(
    Map<String, dynamic> json,
    String docId,
    String qurbaniIdentifier,
  ) {
    return ExpenseModel(
      identifier: docId,
      qurbaniIdentifier: qurbaniIdentifier,
      notes: json['notes'],
      amount: json['amount'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
      'amount': amount,
      'category': category,
      'createdOn': createdOn.toUtc().toIso8601String(),
      'updatedOn': updatedOn.toUtc().toIso8601String(),
      'isLocal': isLocal,
    };
  }
}

class ContributionModel extends Spending {
   String shareholder;

  ContributionModel({
    required super.identifier,
    required super.qurbaniIdentifier,
    required super.notes,
    required super.amount,
    required super.createdOn,
    required super.updatedOn,
    required this.shareholder,
    super.isLocal = false,
  });

  factory ContributionModel.fromJson(
    Map<String, dynamic> json,
    String docId,
    String qurbaniIdentifier,
  ) {
    return ContributionModel(
      identifier: docId,
      qurbaniIdentifier: qurbaniIdentifier,
      notes: json['notes'],
      amount: json['amount'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
      shareholder: json['shareholder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
      'amount': amount,
      'shareholder': shareholder,
      'createdOn': createdOn.toUtc().toIso8601String(),
      'updatedOn': updatedOn.toUtc().toIso8601String(),
      'isLocal': isLocal,
    };
  }
}
