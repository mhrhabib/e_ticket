class UserEntity {
  final int id;
  final String name;
  final String username;
  final int ticketCounterId;
  final String fromTicketCounterName;
  final String fromTicketCounterNameBn;
  final String counterShortName;
  final int deviceId;
  final String mobile;
  final String address;
  final String token;

  UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.ticketCounterId,
    required this.fromTicketCounterName,
    required this.fromTicketCounterNameBn,
    required this.counterShortName,
    required this.deviceId,
    required this.mobile,
    required this.address,
    required this.token,
  });
}
