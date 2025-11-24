// BridgeKycWidget implementation with Persona KYC flow

import 'package:flutter/material.dart';

import '../utils/bridge_url_parser.dart';
import '../utils/persona_kyc.dart';

/// A widget that takes a Persona Bridge KYC URL, extracts the template ID,
/// displays it, and provides a button to start the KYC flow.
///
/// Callbacks are forwarded from the underlying Persona SDK.
class BridgeKycWidget extends StatelessWidget {
  final String bridgeUrl;
  final Function(String inquiryId, String status, Map<String, dynamic> fields)?
  onSuccess;
  final Function(String error)? onError;
  final Function()? onCancelled;

  const BridgeKycWidget({
    super.key,
    required this.bridgeUrl,
    this.onSuccess,
    this.onError,
    this.onCancelled,
  });

  @override
  Widget build(BuildContext context) {
    final templateId = extractTemplateIdFromUrl(bridgeUrl);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Persona Bridge KYC',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('URL: $bridgeUrl'),
            const SizedBox(height: 8),
            if (templateId != null)
              Text(
                'Template ID: $templateId',
                style: const TextStyle(color: Colors.green),
              )
            else
              const Text(
                'Template ID not found',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await startPersonaKycFromUrl(
                  bridgeUrl: bridgeUrl,
                  onSuccess: onSuccess,
                  onError: onError,
                  onCancelled: onCancelled,
                );
              },
              child: const Text('Start KYC'),
            ),
          ],
        ),
      ),
    );
  }
}
