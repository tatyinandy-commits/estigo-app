class Payout {
  final String id;
  final double amount;
  final double fee;
  final String iban;
  final String recipientName;
  final String status;
  final String? processedAt;
  final String createdAt;

  const Payout({
    required this.id,
    required this.amount,
    required this.fee,
    required this.iban,
    required this.recipientName,
    required this.status,
    this.processedAt,
    required this.createdAt,
  });

  factory Payout.fromJson(Map<String, dynamic> json) {
    return Payout(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      iban: json['iban'] as String,
      recipientName: json['recipientName'] as String,
      status: json['status'] as String,
      processedAt: json['processedAt'] as String?,
      createdAt: json['createdAt'] as String,
    );
  }
}
