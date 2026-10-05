import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tenant_app/features/service_requests/data/models/request_status.dart';
import 'package:tenant_app/features/service_requests/presentation/widgets/request_status_filter_widget.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows counts and reports the tapped status', (tester) async {
    RequestStatus? selected = RequestStatus.completed;
    await tester.pumpApp(
      Scaffold(
        body: RequestStatusFilterWidget(
          selectedStatus: selected,
          counts: const {null: 3, RequestStatus.pending: 2},
          onChanged: (status) => selected = status,
        ),
      ),
    );

    expect(find.text('All · 3'), findsOneWidget);
    expect(find.text('Pending · 2'), findsOneWidget);
    // Statuses without a count show the bare label.
    expect(find.text('Assigned'), findsOneWidget);

    await tester.tap(find.text('All · 3'));
    expect(selected, isNull);
  });
}
