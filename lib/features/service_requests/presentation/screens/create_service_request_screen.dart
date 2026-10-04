import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/data/utils/constants.dart';
import 'package:tenant_app/core/presentation/widgets/base_card_widget.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_elevated_button.dart';
import 'package:tenant_app/core/presentation/widgets/date_picker/base_reactive_date_picker.dart';
import 'package:tenant_app/core/presentation/widgets/fields/base_reactive_text_field.dart';
import 'package:tenant_app/core/presentation/widgets/reactive_switch_list_tile.dart';
import 'package:tenant_app/core/presentation/widgets/responsive_center_widget.dart';
import 'package:tenant_app/core/presentation/widgets/screen_loader.dart';
import 'package:tenant_app/core/presentation/widgets/screen_utils.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/ext/date_time_ext.dart';
import 'package:tenant_app/core/utils/media_picker_utils.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/providers/create_service_request/create_service_request_notifier.dart';
import 'package:tenant_app/features/service_requests/presentation/ui-models/create_service_request_input.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/reactive_image_attachment_field.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_requests_screen.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/reactive_service_type_selection.dart';
import 'package:tenant_app/injectable_module.dart';

class CreateServiceRequestScreen extends ConsumerStatefulWidget {
  const CreateServiceRequestScreen({this.initialServiceType, super.key});

  /// Pre-selected when opened from a Home quick-access tile.
  final ServiceType? initialServiceType;

  static const String routePath = '/create-service-request';

  @override
  ConsumerState<CreateServiceRequestScreen> createState() => _CreateServiceRequestScreenState();
}

class _CreateServiceRequestScreenState extends ConsumerState<CreateServiceRequestScreen>
    with ScreenLoader, ScreenUtils {
  late final DateTime _firstDate = DateTime.now().dateOnly;
  late final DateTime _lastDate = _firstDate.add(const Duration(days: kPreferredDateMaxDaysAhead));

  @override
  Widget screen(BuildContext context) {
    ref.listen<CreateServiceRequestState>(createServiceRequestProvider, (previous, state) {
      switch (state) {
        case CreateServiceRequestLoading():
          startLoading();
        case CreateServiceRequestFailure(:final failure):
          stopLoading();
          handleError(failure: failure);
        case CreateServiceRequestSuccessful():
          stopLoading();
          showSuccess(customMessage: context.l10n.request_submitted_successfully);
          // Land on the Requests tab so the tenant sees the new request.
          context.go(ServiceRequestsScreen.routePath);
        case CreateServiceRequestInitial():
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.new_service_request)),
      body: ReactiveFormBuilder(
        form: () => CreateServiceRequestInputForm.buildFormGroup(
          CreateServiceRequestInput(serviceType: widget.initialServiceType),
        ),
        builder: (BuildContext context, FormGroup formGroup, Widget? child) {
          final form = CreateServiceRequestInputForm(formGroup);
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: ResponsiveCenterWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionLabel(label: context.l10n.service_type),
                          const SpacerH8(),
                          ReactiveServiceTypeSelection(
                            formControl: form.serviceTypeControl,
                            validationMessages: {
                              ValidationMessage.required: (_) => context.l10n.please_choose_a_service_type,
                            },
                          ),
                          const SpacerH24(),
                          BaseReactiveTextField.borderedTextField(
                            controller: form.descriptionControl,
                            label: context.l10n.description,
                            hintText: context.l10n.description_hint,
                            maxLines: 5,
                            minLines: 4,
                            maxLength: kMaxDescriptionLength,
                            validationMessages: {
                              ValidationMessage.minLength: (_) =>
                                  context.l10n.description_must_be_at_least_n_characters(kMinDescriptionLength),
                            },
                          ),
                          const SpacerH16(),
                          BaseReactiveDatePicker.borderedTextField(
                            controller: form.preferredDateControl,
                            firstDate: _firstDate,
                            lastDate: _lastDate,
                            label: context.l10n.preferred_date,
                            hint: context.l10n.select_a_date,
                            validationMessages: {
                              ValidationMessage.required: (_) => context.l10n.please_choose_a_preferred_date,
                            },
                          ),
                          const SpacerH24(),
                          BaseCardWidget(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                            child: ReactiveSwitchListTile(
                              formControl: form.isUrgentControl,
                              titleText: context.l10n.urgent_request,
                              subtitleText: context.l10n.urgent_request_description,
                              leading: BaseIconContainerWidget(
                                icon: Icons.priority_high_rounded,
                                color: context.colors.urgent,
                                size: 40.r,
                              ),
                            ),
                          ),
                          const SpacerH24(),
                          _SectionLabel(label: context.l10n.photo_optional),
                          const SpacerH8(),
                          ReactiveImageAttachmentField(
                            formControl: form.imagePathControl,
                            onPickImage: () => MediaPickerUtils.pickImage(
                              context: context,
                              imagePicker: ref.read(imagePickerProvider),
                              onError: () => showError(customMessage: context.l10n.could_not_access_photos),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _SubmitBar(onSubmit: () => submit(form)),
              ],
            ),
          );
        },
      ),
    );
  }

  void submit(CreateServiceRequestInputForm form) {
    if (!form.form.valid) {
      form.form.markAllAsTouched();
      return;
    }
    ref.read(createServiceRequestProvider.notifier).createServiceRequest(form.model);
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) =>
      Text(label, style: context.titleSmall?.copyWith(color: context.colors.cardTitle));
}

class _SubmitBar extends StatelessWidget {
  const _SubmitBar({required this.onSubmit});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.colors.borderColor)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        child: ResponsiveCenterWidget(
          child: BaseElevatedButton.primary(
            label: context.l10n.submit_request,
            onPressed: onSubmit,
          ),
        ),
      ),
    );
  }
}
