import 'package:clean_architecture/features/user/domain/entities/sub_entities/address_entity.dart';

class UserEntity {
  final String name;
  final String phone;
  final String email;
  final AddressEntity address;

  UserEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });
}
