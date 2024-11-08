import 'package:json_annotation/json_annotation.dart';

part 'parameters.g.dart';

@JsonEnum()
enum SortMethod {
  az, // title up
  za, // title down
  dt, // created_at up
  td, // created_at down
}

@JsonEnum()
enum StorageType {
  internal,
  external,
}

@JsonSerializable()
class Parameters {
  final SortMethod sortMethod;
  final StorageType storageType;

  Parameters({
    required this.sortMethod,
    required this.storageType,
  });

  factory Parameters.defaults() => Parameters(
        sortMethod: SortMethod.az,
        storageType: StorageType.internal,
      );

  factory Parameters.fromJson(Map<String, dynamic> json) =>
      _$ParametersFromJson(json);

  Map<String, dynamic> toJson() => _$ParametersToJson(this);
}
