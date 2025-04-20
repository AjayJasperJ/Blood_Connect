class DonationHistory {
  final String id;
  final String requestId;
  final String status;
  final String bloodUnitReceived;
  final String updatedTime;

  DonationHistory(
      {required this.id,
      required this.requestId,
      required this.status,
      required this.bloodUnitReceived,
      required this.updatedTime});

  factory DonationHistory.fromJson(Map<String, dynamic> json) {
    return DonationHistory(
      id: json['id'],
      requestId: json['request_id'],
      status: json['status'],
      bloodUnitReceived: json['blood_unit_received'],
      // comments : json['comments'],
      updatedTime: json['updated_time'],
    );
  }
}
