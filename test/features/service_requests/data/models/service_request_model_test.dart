import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fakers.dart';

void main() {
  group('ServiceRequestModel.referenceNumber', () {
    test('uses the first 8 characters of the id, without dashes', () {
      expect(fakeServiceRequestModel(id: '3f9a1c2e-7b4d-4e21').referenceNumber, 'REQ-3F9A1C2E');
    });

    test('keeps short ids whole', () {
      expect(fakeServiceRequestModel(id: 'ab-12').referenceNumber, 'REQ-AB12');
    });
  });
}
