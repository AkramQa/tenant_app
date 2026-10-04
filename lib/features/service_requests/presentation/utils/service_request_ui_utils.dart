import 'package:flutter/material.dart';
import 'package:tenant_app/core/utils/ext/build_context_ext.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';

extension ServiceTypeUi on ServiceType {
  String translated(BuildContext context) => switch (this) {
        ServiceType.maintenance => context.l10n.service_maintenance,
        ServiceType.plumbing => context.l10n.service_plumbing,
        ServiceType.electrical => context.l10n.service_electrical,
        ServiceType.acMaintenance => context.l10n.service_ac_maintenance,
        ServiceType.cleaning => context.l10n.service_cleaning,
        ServiceType.unknown => context.l10n.unknown,
      };

  IconData get icon => switch (this) {
        ServiceType.maintenance => Icons.handyman_outlined,
        ServiceType.plumbing => Icons.plumbing_rounded,
        ServiceType.electrical => Icons.electrical_services_rounded,
        ServiceType.acMaintenance => Icons.ac_unit_rounded,
        ServiceType.cleaning => Icons.cleaning_services_outlined,
        ServiceType.unknown => Icons.help_outline_rounded,
      };

  Color color(BuildContext context) => switch (this) {
        ServiceType.maintenance => context.colors.serviceMaintenance,
        ServiceType.plumbing => context.colors.servicePlumbing,
        ServiceType.electrical => context.colors.serviceElectrical,
        ServiceType.acMaintenance => context.colors.serviceAcMaintenance,
        ServiceType.cleaning => context.colors.serviceCleaning,
        ServiceType.unknown => context.colors.secondary,
      };
}

extension RequestStatusUi on RequestStatus {
  String translated(BuildContext context) => switch (this) {
        RequestStatus.pending => context.l10n.status_pending,
        RequestStatus.assigned => context.l10n.status_assigned,
        RequestStatus.inProgress => context.l10n.status_in_progress,
        RequestStatus.completed => context.l10n.status_completed,
        RequestStatus.unknown => context.l10n.unknown,
      };

  String description(BuildContext context) => switch (this) {
        RequestStatus.pending => context.l10n.status_pending_description,
        RequestStatus.assigned => context.l10n.status_assigned_description,
        RequestStatus.inProgress => context.l10n.status_in_progress_description,
        RequestStatus.completed => context.l10n.status_completed_description,
        RequestStatus.unknown => '',
      };

  IconData get icon => switch (this) {
        RequestStatus.pending => Icons.schedule_rounded,
        RequestStatus.assigned => Icons.engineering_outlined,
        RequestStatus.inProgress => Icons.build_circle_outlined,
        RequestStatus.completed => Icons.check_circle_outline_rounded,
        RequestStatus.unknown => Icons.help_outline_rounded,
      };

  Color color(BuildContext context) => switch (this) {
        RequestStatus.pending => context.colors.statusPending,
        RequestStatus.assigned => context.colors.statusAssigned,
        RequestStatus.inProgress => context.colors.statusInProgress,
        RequestStatus.completed => context.colors.statusCompleted,
        RequestStatus.unknown => context.colors.secondary,
      };
}
