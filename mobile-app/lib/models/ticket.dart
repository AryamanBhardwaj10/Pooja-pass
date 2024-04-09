class Ticket {
  final String id;
  final String userId;
  final String ticketDate;
  final List<String> memberNames;
  final String qrCode;
  final String ticketStatus;

  Ticket({
    required this.id,
    required this.userId,
    required this.ticketDate,
    required this.memberNames,
    required this.qrCode,
    required this.ticketStatus,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json['_id'] as String,
        userId: json['userId'] as String,
        ticketDate: json['ticketDate'] as String,
        memberNames: (json['memberNames'] as List<dynamic>).cast<String>(),
        qrCode: json['qrCode'] as String,
        ticketStatus: json['ticketStatus'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'ticketDate': ticketDate,
        'memberNames': memberNames,
        'qrCode': qrCode,
        'ticketStatus': ticketStatus,
      };
}
