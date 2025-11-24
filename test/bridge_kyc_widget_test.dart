// Widget tests for BridgeKycWidget

import 'package:flutter/material.dart';
import 'package:flutter_bridge_persona_sdk/widgets/bridge_kyc_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Displays template ID when URL is valid', (
    WidgetTester tester,
  ) async {
    const bridgeUrl =
        'https://bridge.withpersona.com/verify?inquiry-template-id=itmpl_ABC123&reference-id=user_123';
    await tester.pumpWidget(
      const MaterialApp(home: BridgeKycWidget(bridgeUrl: bridgeUrl)),
    );
    // Verify that the template ID is shown
    expect(find.text('Template ID: itmpl_ABC123'), findsOneWidget);
  });

  testWidgets('Shows error message when template ID missing', (
    WidgetTester tester,
  ) async {
    const bridgeUrl =
        'https://bridge.withpersona.com/verify?reference-id=user_123';
    await tester.pumpWidget(
      const MaterialApp(home: BridgeKycWidget(bridgeUrl: bridgeUrl)),
    );
    expect(find.text('Template ID not found'), findsOneWidget);
  });
}
