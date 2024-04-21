abstract class QRCodeEvent {}

class QRCodeScanned extends QRCodeEvent {
  final String qrCodeData;
  QRCodeScanned(this.qrCodeData);
}

class GenerateQRCode extends QRCodeEvent {
  final String dataToEncode;
  GenerateQRCode(this.dataToEncode);
}
