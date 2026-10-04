import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/core/utils/forms/validators/email_or_phone_validator.dart';

/// Default localized messages for every reactive form in the app
/// (fed to `ReactiveFormConfig` in `App`).
Map<String, String Function(Object)> appValidationMessages(BuildContext context) => {
      ValidationMessage.required: (_) => context.l10n.field_required_message,
      ValidationMessage.email: (_) => context.l10n.invalid_email_error_message,
      ValidationMessage.minLength: (error) => context.l10n.min_length_error_message(
            error is Map ? (error['requiredLength'] as int? ?? 0) : 0,
          ),
      ValidationMessage().emailOrPhone: (_) => context.l10n.invalid_email_or_phone_number,
    };
