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
}
