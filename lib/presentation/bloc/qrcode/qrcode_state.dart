abstract class QRCodeState {}

class QRCodeInitial extends QRCodeState {}

class QRCodeLoaded extends QRCodeState {
  final String qrCodeData;
  QRCodeLoaded(this.qrCodeData);
}

class QRCodeGenerated extends QRCodeState {
  final String data;
  QRCodeGenerated(this.data);
}
