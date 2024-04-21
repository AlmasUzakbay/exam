import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/presentation/bloc/qrcode/qrcode_state.dart';
import 'package:flutter_education/presentation/bloc/qrcode/qrcose_event.dart';

class QRCodeBloc extends Bloc<QRCodeEvent, QRCodeState> {
  QRCodeBloc() : super(QRCodeInitial()) {
    on<QRCodeScanned>((event, emit) {
      emit(QRCodeLoaded(event.qrCodeData));
    });
    on<GenerateQRCode>((event, emit) {
      var qrData = event.dataToEncode;
      emit(QRCodeGenerated(qrData as String));
    });
  }
}
