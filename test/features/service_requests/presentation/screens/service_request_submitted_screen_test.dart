import 'package:flutter_test/flutter_test.dart';
import 'package:tenant_app/features/service_requests/data/models/service_type.dart';
import 'package:tenant_app/features/service_requests/presentation/screens/service_request_submitted_screen.dart';

import '../../../../helpers/fakers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('summarises the submitted request', (tester) async {
    final request = fakeServiceRequestModel(id: '3f9a1c2e-7b4d', serviceType: ServiceType.cleaning, isUrgent: true);

    await tester.pumpApp(ServiceRequestSubmittedScreen(serviceRequest: request));

    expect(find.text('Request submitted'), findsOneWidget);
    expect(find.text('REQ-3F9A1C2E'), findsOneWidget);
    expect(find.text('Urgent'), findsOneWidget);
    expect(find.text('View request'), findsOneWidget);
    expect(find.text('Back to home'), findsOneWidget);
  });
}
