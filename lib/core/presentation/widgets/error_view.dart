import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/domain/entities/failures.dart';
import 'package:tenant_app/core/domain/utils/constants.dart';
import 'package:tenant_app/core/presentation/widgets/base_icon_container_widget.dart';
import 'package:tenant_app/core/presentation/widgets/buttons/base_elevated_button.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final Function() onRetry;
  final Failure? failure;
  final String? actionText;
  final Map<ServerErrorCode, String>? customMessages;

  const ErrorView({
    super.key,
    required this.onRetry,
    this.message,
    this.failure,
    this.actionText,
    this.customMessages,
  });

  bool get _isNoInternet =>
      failure is ServerFailure && (failure as ServerFailure).errorCode == ServerErrorCode.noInternetConnection;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseIconContainerWidget(
              icon: _isNoInternet ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
              color: context.colors.error,
              size: 72.r,
            ),
            const SpacerH24(),
            Text(
              _isNoInternet ? context.l10n.no_internet_connection : context.l10n.something_went_wrong,
              style: context.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SpacerH8(),
            Text(
              message ?? _resolveMessage(context),
              style: context.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SpacerH24(),
            BaseElevatedButton.primary(
              label: actionText ?? context.l10n.retry,
              onPressed: onRetry,
              isFullWidth: false,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
      ),
    );
  }

  String _resolveMessage(BuildContext context) {
    final failure = this.failure;
    if (failure is ServerFailure) {
      final custom = customMessages?[failure.errorCode];
      if (custom != null) return custom;
      if (failure.errorCode == ServerErrorCode.notFound) return context.l10n.the_requested_item_was_not_found;
    }
    return _isNoInternet
        ? context.l10n.looks_like_you_are_offline_please_check_your_connection_and_try_again
        : context.l10n.we_couldnt_load_the_data_please_try_again;
  }
}
