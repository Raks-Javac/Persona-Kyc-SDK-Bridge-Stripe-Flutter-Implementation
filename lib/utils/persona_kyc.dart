// Persona KYC helper functions (simplified)

import 'dart:async';

import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:persona_flutter/persona_flutter.dart';

import 'bridge_url_parser.dart';

/// Stream subscriptions for Persona events
late StreamSubscription<InquiryCanceled> _streamCanceled;
late StreamSubscription<InquiryError> _streamError;
late StreamSubscription<InquiryComplete> _streamComplete;

/// Initialize Persona event listeners
void initializePersonaListeners({
  Function(String? inquiryId, String? sessionToken)? onCancelled,
  Function(String error)? onError,
  Function(String inquiryId, String status, Map<String, dynamic> fields)?
  onComplete,
}) {
  _streamCanceled = PersonaInquiry.onCanceled.listen((event) {
    debugPrint('PersonaKYC: Inquiry cancelled');
    debugPrint('PersonaKYC: Inquiry ID: ${event.inquiryId}');
    debugPrint('PersonaKYC: Session Token: ${event.sessionToken}');
    onCancelled?.call(event.inquiryId, event.sessionToken);
  });

  _streamError = PersonaInquiry.onError.listen((event) {
    debugPrint('PersonaKYC: Error occurred: ${event.error}');
    onError?.call(event.error ?? "");
  });

  _streamComplete = PersonaInquiry.onComplete.listen((event) {
    debugPrint('PersonaKYC: Inquiry completed successfully');
    debugPrint('PersonaKYC: Inquiry ID: ${event.inquiryId}');
    debugPrint('PersonaKYC: Status: ${event.status}');
    debugPrint('PersonaKYC: Fields: ${event.fields}');
    onComplete?.call(event.inquiryId ?? "", event.status, event.fields);
  });
}

/// Dispose Persona event listeners
void disposePersonaListeners() {
  _streamCanceled.cancel();
  _streamError.cancel();
  _streamComplete.cancel();
}

/// Start Persona KYC flow from a bridge URL
Future<void> startPersonaKycFromUrl({
  required String bridgeUrl,
  InquiryEnvironment environment = InquiryEnvironment.production,
  Function(String inquiryId, String status, Map<String, dynamic> fields)?
  onSuccess,
  Function(String error)? onError,
  Function()? onCancelled,
}) async {
  try {
    // Simple loading indication (could be replaced with a proper UI)
    debugPrint('PersonaKYC: Loading...');

    final templateId = extractTemplateIdFromUrl(bridgeUrl);
    if (templateId == null || templateId.isEmpty) {
      debugPrint('PersonaKYC: Template ID not found in URL');
      onError?.call('Template ID not found in URL');
      return;
    }

    final referenceId = extractReferenceIdFromUrl(bridgeUrl);
    final fields = extractFieldsFromUrl(bridgeUrl);

    // Initialize listeners
    initializePersonaListeners(
      onComplete: onSuccess,
      onError: onError,
      onCancelled: (id, token) => onCancelled?.call(),
    );

    final configuration = TemplateIdConfiguration(
      templateId: templateId,
      environment: environment,
      referenceId: referenceId,
      fields: fields,
      theme: InquiryTheme(source: InquiryThemeSource.client),
    );

    debugPrint('PersonaKYC: Starting Persona inquiry');
    PersonaInquiry.init(configuration: configuration);
    PersonaInquiry.start();
  } catch (e, stackTrace) {
    debugPrint('PersonaKYC: Exception: $e');
    debugPrint('PersonaKYC: StackTrace: $stackTrace');
    onError?.call('Unexpected error: $e');
  }
}
