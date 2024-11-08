import 'package:json_annotation/json_annotation.dart';
import 'package:teatone/src/features/storage/storage.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  final String title;
  final String path;
  final DateTime createdAt;
  final StorageType type;

  Record({
    required this.title,
    required this.path,
    required this.createdAt,
    required this.type,
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
