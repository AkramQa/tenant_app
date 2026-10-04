import 'package:flutter/material.dart';
import 'package:tenant_app/core/presentation/widgets/tag_label.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/presentation/utils/service_request_ui_utils.dart';

class RequestStatusTagWidget extends StatelessWidget {
  const RequestStatusTagWidget({required this.status, super.key});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    return TagLabel(label: status.translated(context), color: status.color(context), showDot: true);
  }
}
