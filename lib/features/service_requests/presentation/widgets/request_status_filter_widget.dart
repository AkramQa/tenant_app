import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

/// Horizontal "All / Pending / Assigned / …" filter. `null` = all.
class RequestStatusFilterWidget extends StatelessWidget {
  const RequestStatusFilterWidget({
    required this.selectedStatus,
    required this.onChanged,
    this.counts = const {},
    super.key,
  });

  final RequestStatus? selectedStatus;

  /// Requests per status; `null` key = all. Omitted statuses show no count.
  final Map<RequestStatus?, int> counts;
  final ValueChanged<RequestStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    final List<RequestStatus?> options = [null, ...RequestStatus.getValues()];
    // Sized by its chips (no fixed height) so large text never clips and
    // each chip keeps its 48dp tap target.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          for (final RequestStatus? status in options) ...[
            if (status != options.first) const SpacerW8(),
            _buildChip(context, status),
          ],
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, RequestStatus? status) {
    final bool isSelected = status == selectedStatus;
    return ChoiceChip(
      label: Text(_label(context, status)),
      selected: isSelected,
      onSelected: (_) => onChanged(status),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      labelStyle: context.labelMedium?.copyWith(
        color: isSelected ? context.colors.primary : context.colors.cardSubTitle,
      ),
      side: BorderSide(color: isSelected ? context.colors.primary : context.colors.borderColor),
    );
  }

  String _label(BuildContext context, RequestStatus? status) {
    final String name = status?.translated(context) ?? context.l10n.all;
    final int? count = counts[status];
    return count == null ? name : '$name · $count';
  }
}
