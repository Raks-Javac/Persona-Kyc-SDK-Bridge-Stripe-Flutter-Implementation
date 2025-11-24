// Utility functions for parsing Persona Bridge URLs

/// Extract template ID from Persona Bridge URL
/// Returns the template ID or null if not found
String? extractTemplateIdFromUrl(String url) {
  try {
    final uri = Uri.parse(url);
    final templateId = uri.queryParameters['inquiry-template-id'];
    if (templateId != null && templateId.isNotEmpty) {
      return templateId;
    }
    return null;
  } catch (_) {
    return null;
  }
}

/// Extract reference ID from Persona Bridge URL
String? extractReferenceIdFromUrl(String url) {
  try {
    final uri = Uri.parse(url);
    return uri.queryParameters['reference-id'];
  } catch (_) {
    return null;
  }
}

/// Extract custom fields from Persona Bridge URL
Map<String, dynamic> extractFieldsFromUrl(String url) {
  final fields = <String, dynamic>{};
  try {
    final uri = Uri.parse(url);
    uri.queryParameters.forEach((key, value) {
      if (key.startsWith('fields[') && key.endsWith(']')) {
        final fieldName = key.substring(7, key.length - 1);
        fields[fieldName] = value;
      }
    });
  } catch (_) {}
  return fields;
}
