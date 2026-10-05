import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tenant_app/core/utils/functions.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

part 'create_service_request_body_model.freezed.dart';
part 'create_service_request_body_model.g.dart';

/// Body of `POST /service-requests`.
@freezed
abstract class CreateServiceRequestBodyModel with _$CreateServiceRequestBodyModel {
  const factory CreateServiceRequestBodyModel({
    @JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)
    required ServiceType serviceType,
    required String description,
    @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)
    required DateTime preferredDate,
    @Default(false) bool isUrgent,
    String? imageFileName,
  }) = _CreateServiceRequestBodyModel;

  factory CreateServiceRequestBodyModel.fromJson(Map<String, dynamic> json) =>
      _$CreateServiceRequestBodyModelFromJson(json);
}
