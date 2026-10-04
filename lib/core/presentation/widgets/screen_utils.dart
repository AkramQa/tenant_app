import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

mixin ScreenUtils<T extends StatefulWidget> on State<T> {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? handleError({
    Failure? failure,
    BuildContext? scaffoldContext,
    String? customMessage,
    Map<ServerErrorCode, String>? customMessages,
  }) {
    return showError(
      failure: failure,
      scaffoldContext: scaffoldContext,
      customMessage: customMessage,
      customMessages: customMessages,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError({
    Failure? failure,
    BuildContext? scaffoldContext,
    String? customMessage,
    Map<ServerErrorCode, String>? customMessages,
  }) {
    String message = customMessage ?? context.l10n.errorMessage;
    if (failure != null && failure is ServerFailure) {
      if (customMessages != null && customMessages.containsKey(failure.errorCode)) {
        message = customMessages[failure.errorCode]!;
      } else if (failure.errorCode == ServerErrorCode.noInternetConnection) {
        message = context.l10n.noInternetConnectionMessage;
      } else if (failure.errorCode == ServerErrorCode.serverError) {
        message = failure.message.isNotEmpty ? failure.message : context.l10n.serverNotWorking;
      } else if (failure.message.isNotEmpty) {
        message = failure.message;
      }
    } else if (failure != null && failure is LogicFailure && customMessage == null) {
      message = context.l10n.errorMessage;
    } else if (failure != null && failure is CacheFailure && customMessage == null) {
      message = context.l10n.cacheErrorMessage;
    }

    final messenger = ScaffoldMessenger.of(scaffoldContext ?? context)..hideCurrentSnackBar();
    return messenger.showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: Text(message, style: TextStyle(color: context.colors.onErrorContainer)),
        backgroundColor: context.colors.errorContainer,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccess({
    BuildContext? scaffoldContext,
    String? customMessage,
  }) {
    final String message = customMessage ?? context.l10n.success;
    final messenger = ScaffoldMessenger.of(scaffoldContext ?? context)..hideCurrentSnackBar();
    return messenger.showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: context.colors.onTertiary)),
        backgroundColor: context.colors.tertiary,
      ),
    );
  }
}
