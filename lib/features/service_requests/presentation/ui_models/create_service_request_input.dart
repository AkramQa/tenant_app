import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/utils/forms/validators/not_blank_validator.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

part 'create_service_request_input.freezed.dart';
part 'create_service_request_input.gform.dart';

@freezed
@ReactiveFormAnnotation()
abstract class CreateServiceRequestInput with _$CreateServiceRequestInput {
  factory CreateServiceRequestInput({
    @FormControlAnnotation(validators: [RequiredValidator()]) ServiceType? serviceType,
    @FormControlAnnotation(
      validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)],
    )
    @Default('')
    String description,
    @FormControlAnnotation(validators: [RequiredValidator()]) DateTime? preferredDate,
    @FormControlAnnotation() @Default(false) bool isUrgent,
    @FormControlAnnotation() String? imagePath,
  }) = _CreateServiceRequestInput;
}
