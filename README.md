# Flutter Bridge Persona SDK

A lightweight Flutter package that wraps the **Persona** KYC SDK and provides utility helpers for working with Persona Bridge URLs.


## Screenshots

![Screenshot 1](/Users/kudusrufai/Desktop/codes/mobile/flutter_bridge_persona_sdk/screenshots/screen_shot_1.png)

![Screenshot 2](/Users/kudusrufai/Desktop/codes/mobile/flutter_bridge_persona_sdk/screenshots/screen_shot_2.png)

![Screenshot 3](/Users/kudusrufai/Desktop/codes/mobile/flutter_bridge_persona_sdk/screenshots/screen_shot_3.png)

![Screenshot 4](/Users/kudusrufai/Desktop/codes/mobile/flutter_bridge_persona_sdk/screenshots/screen_shot_4.png)

![Screenshot 5](/Users/kudusrufai/Desktop/codes/mobile/flutter_bridge_persona_sdk/screenshots/screen_shot_5.png)


## Features
- Initialise Persona KYC flows from a bridge URL.
- Extract template ID, reference ID and custom fields from the URL.
- Simple `BridgeKycWidget` (now located in `widgets/`) for quick UI preview.

## Installation
Add the following to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  persona_flutter: ^3.2.10
```
Run `flutter pub get`.

## Usage
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bridge_persona_sdk/utils/bridge_kyc_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const bridgeUrl = 'https://bridge.withpersona.com/verify?inquiry-template-id=itmpl_ABC123&reference-id=user_123';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Bridge KYC Demo')),
        body: const Center(
          child: BridgeKycWidget(
            bridgeUrl: bridgeUrl,
            // Optional callbacks:
            // onSuccess: (id, status, fields) => print('Success: $id'),
            // onError: (error) => print('Error: $error'),
            // onCancelled: () => print('Cancelled'),
          ),
        ),
      ),
    );
  }
}
```

## Contributing
1. Fork the repository.
2. Create a feature branch.
3. Write tests (`flutter test`).
4. Submit a pull request.

Made with Love by [Kudusrufai](https://github.com/Raks-Javac)# Persona-Kyc-SDK-Bridge-Stripe-Flutter-Implementation
