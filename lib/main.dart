name: catbook
description: Simple Flutter app with NFT/QR placeholder for cats.
publish_to: "none"
version: 0.1.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  provider: ^6.1.2
  qr_flutter: ^4.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

# سيتم حقن الأسطر التالية تلقائياً من الـ Workflow إن لم تكن موجودة:
# flutter:
#   uses-material-design: true
#   assets:
#     - assets/images/