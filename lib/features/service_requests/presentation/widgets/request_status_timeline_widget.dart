import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tenant_app/core/presentation/widgets/spacer_widgets.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

/// Vertical progress: Pending → Assigned → In Progress → Completed.
class RequestStatusTimelineWidget extends StatelessWidget {
  const RequestStatusTimelineWidget({required this.status, super.key});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    final List<RequestStatus> steps = RequestStatus.getValues();
    return Column(
      children: [
        for (int index = 0; index < steps.length; index++)
          _TimelineStep(
            status: steps[index],
            isReached: index <= status.step,
            isCurrent: index == status.step,
            isLast: index == steps.length - 1,
          ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.status,
    required this.isReached,
    required this.isCurrent,
    required this.isLast,
  });

  final RequestStatus status;
  final bool isReached;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = status.color(context);
    final Color inactiveColor = context.colors.surfaceContainerHighest;
    final double indicatorSize = 28.r;

    return Semantics(
      label: '${status.translated(context)}${isCurrent ? ', ${context.l10n.current_status}' : ''}',
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  width: indicatorSize,
                  height: indicatorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isReached ? activeColor : context.colors.surface,
                    border: Border.all(color: isReached ? activeColor : inactiveColor, width: 2),
                  ),
                  child: Icon(
                    isReached && !isCurrent ? Icons.check_rounded : status.icon,
                    size: indicatorSize * 0.55,
                    color: isReached ? context.colors.white : context.colors.onSurfaceVariant,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: EdgeInsets.symmetric(vertical: 2.h),
                      color: isReached && !isCurrent ? activeColor : inactiveColor,
                    ),
                  ),
              ],
            ),
            const SpacerW12(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h, top: 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status.translated(context),
                      style: context.titleSmall?.copyWith(
                        color: isReached ? context.colors.cardTitle : context.colors.onSurfaceVariant,
                        fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    const SpacerH4(),
                    Text(
                      status.description(context),
                      style: context.bodySmall?.copyWith(color: context.colors.cardSubTitle),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
