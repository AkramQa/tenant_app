import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/utils/forms/validators/not_blank_validator.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

class CreateServiceRequestInput {
  final ServiceType? serviceType;
  final String description;
  final DateTime? preferredDate;
  final bool isUrgent;
  final String? imagePath;

  CreateServiceRequestInput({
    this.serviceType,
    this.description = '',
    this.preferredDate,
    this.isUrgent = false,
    this.imagePath,
  });
}

/// Typed access to the create-request [FormGroup].
class CreateServiceRequestInputForm {
  CreateServiceRequestInputForm(this.form);

  final FormGroup form;

  static const String serviceTypeControlName = 'serviceType';
  static const String descriptionControlName = 'description';
  static const String preferredDateControlName = 'preferredDate';
  static const String isUrgentControlName = 'isUrgent';
  static const String imagePathControlName = 'imagePath';

  static FormGroup buildFormGroup([CreateServiceRequestInput? model]) => FormGroup({
        serviceTypeControlName: FormControl<ServiceType>(
          value: model?.serviceType,
          validators: [Validators.required],
        ),
        descriptionControlName: FormControl<String>(
          value: model?.description ?? '',
          validators: [
            Validators.required,
            const NotBlankValidator(),
            Validators.minLength(kMinDescriptionLength),
          ],
        ),
        preferredDateControlName: FormControl<DateTime>(
          value: model?.preferredDate,
          validators: [Validators.required],
        ),
        isUrgentControlName: FormControl<bool>(value: model?.isUrgent ?? false),
        imagePathControlName: FormControl<String>(value: model?.imagePath),
      });

  FormControl<ServiceType> get serviceTypeControl => form.control(serviceTypeControlName) as FormControl<ServiceType>;

  FormControl<String> get descriptionControl => form.control(descriptionControlName) as FormControl<String>;

  FormControl<DateTime> get preferredDateControl =>
      form.control(preferredDateControlName) as FormControl<DateTime>;

  FormControl<bool> get isUrgentControl => form.control(isUrgentControlName) as FormControl<bool>;

  FormControl<String> get imagePathControl => form.control(imagePathControlName) as FormControl<String>;

  CreateServiceRequestInput get model => CreateServiceRequestInput(
        serviceType: serviceTypeControl.value,
        description: descriptionControl.value ?? '',
        preferredDate: preferredDateControl.value,
        isUrgent: isUrgentControl.value ?? false,
        imagePath: imagePathControl.value,
      );
}
