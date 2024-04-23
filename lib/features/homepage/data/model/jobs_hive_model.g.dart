// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobsHiveModelAdapter extends TypeAdapter<JobsHiveModel> {
  @override
  final int typeId = 1;

  @override
  JobsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobsHiveModel(
      jobsId: fields[0] as String?,
      jobsTitle: fields[1] as String,
      companyName: fields[2] as String,
      location: fields[3] as String,
      jobType: fields[4] as String,
      experianceLevel: fields[5] as String,
      educationLevel: fields[6] as String,
      jobDescription: fields[7] as String,
      jobResponsibilities: fields[8] as String,
      contact: fields[9] as String,
      workType: fields[10] as String,
      salary: fields[12] as String,
      companyOverview: fields[13] as String,
      applyBefore: fields[14] as String,
      image: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JobsHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.jobsId)
      ..writeByte(1)
      ..write(obj.jobsTitle)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.jobType)
      ..writeByte(5)
      ..write(obj.experianceLevel)
      ..writeByte(6)
      ..write(obj.educationLevel)
      ..writeByte(7)
      ..write(obj.jobDescription)
      ..writeByte(8)
      ..write(obj.jobResponsibilities)
      ..writeByte(9)
      ..write(obj.contact)
      ..writeByte(10)
      ..write(obj.workType)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.salary)
      ..writeByte(13)
      ..write(obj.companyOverview)
      ..writeByte(14)
      ..write(obj.applyBefore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
