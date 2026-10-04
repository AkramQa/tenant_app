import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

/// Horizontal "All / Pending / Assigned / …" filter. `null` = all.
class RequestStatusFilterWidget extends StatelessWidget {
  const RequestStatusFilterWidget({
    required this.selectedStatus,
    required this.onChanged,
    super.key,
  });

  final RequestStatus? selectedStatus;
  final ValueChanged<RequestStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<RequestStatus?> options = [null, ...RequestStatus.getValues()];
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final RequestStatus? status = options[index];
          final bool isSelected = status == selectedStatus;
          return ChoiceChip(
            label: Text(status?.translated(context) ?? context.l10n.all),
            selected: isSelected,
            onSelected: (_) => onChanged(status),
            labelStyle: context.labelMedium?.copyWith(
              color: isSelected ? context.colors.primary : context.colors.cardSubTitle,
            ),
            side: BorderSide(color: isSelected ? context.colors.primary : context.colors.borderColor),
          );
        },
      ),
    );
  }
}
