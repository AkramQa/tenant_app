import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/service_request_card_widget.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows type, status and the urgent badge for urgent requests', (tester) async {
    var tapped = false;
    await tester.pumpApp(
      Scaffold(
        body: ServiceRequestCardWidget(
          serviceRequest: fakeServiceRequestModel(
            serviceType: ServiceType.acMaintenance,
            status: RequestStatus.inProgress,
            isUrgent: true,
          ),
          onTap: () => tapped = true,
        ),
      ),
    );

    expect(find.text('AC Maintenance'), findsOneWidget);
    expect(find.text('In Progress'), findsOneWidget);
    expect(find.text('Urgent'), findsOneWidget);

    await tester.tap(find.byType(ServiceRequestCardWidget));
    expect(tapped, isTrue);
  });

  testWidgets('hides the urgent badge for normal requests', (tester) async {
    await tester.pumpApp(
      Scaffold(body: ServiceRequestCardWidget(serviceRequest: fakeServiceRequestModel(), onTap: () {})),
    );

    expect(find.text('Urgent'), findsNothing);
  });

  testWidgets('announces the request as one labelled button', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpApp(
      Scaffold(
        body: ServiceRequestCardWidget(
          serviceRequest: fakeServiceRequestModel(status: RequestStatus.pending, isUrgent: true),
          onTap: () {},
        ),
      ),
    );

    expect(
      tester.getSemantics(find.byType(ServiceRequestCardWidget)),
      matchesSemantics(
        label: 'Plumbing, Pending, Urgent, Requested Oct 1, 2026',
        isButton: true,
        hasTapAction: true,
      ),
    );
    semantics.dispose();
  });
}
