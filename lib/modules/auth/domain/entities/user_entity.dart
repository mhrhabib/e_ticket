class UserEntity {
  final int id;
  final String name;
  final String email;
  final String token;
  final int ticketCounterId;

  UserEntity({required this.id, required this.name, required this.email, required this.token, required this.ticketCounterId});
}
