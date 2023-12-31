// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      userID: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[7] as String,
      profileUrl: fields[10] as String?,
      status: fields[8] as bool,
      dateOfBirth: fields[4] as String?,
      address: fields[5] as String?,
      contact: fields[6] as String?,
      gender: fields[3] as String?,
      profilePicName: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.dateOfBirth)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.contact)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.profilePicName)
      ..writeByte(10)
      ..write(obj.profileUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
