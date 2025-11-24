import 'package:flutter/material.dart';
import 'package:flutter_bridge_persona_sdk/widgets/bridge_kyc_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const bridgeUrl =
        'https://bridge.withpersona.com/verify?inquiry-template-id=itmpl_NtHYpb9AbEYCPxGo5iRbc9d2&reference-id=user_123';
    return MaterialApp(
      title: 'Bridge KYC Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Bridge KYC Demo')),
        body: const Center(
          child: BridgeKycWidget(
            bridgeUrl: bridgeUrl,
            // optional callbacks: onSuccess, onError, onCancelled
          ),
        ),
      ),
    );
  }
}
