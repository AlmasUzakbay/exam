import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/generated/locale_keys.g.dart';
import 'package:flutter_education/presentation/ColorConst/ColorConst.dart';
import 'package:flutter_education/presentation/bloc/qrcode/qrcode_bloc.dart';
import 'package:flutter_education/presentation/bloc/qrcode/qrcode_state.dart';
import 'package:flutter_education/presentation/bloc/qrcode/qrcose_event.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Qr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        hintColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
        ),
      ),
      home: BlocProvider(
        create: (context) => QRCodeBloc(),
        child: QRScannerGeneratorPage(),
      ),
    );
  }
}

class QRScannerGeneratorPage extends StatefulWidget {
  @override
  _QRScannerGeneratorPageState createState() => _QRScannerGeneratorPageState();
}

class _QRScannerGeneratorPageState extends State<QRScannerGeneratorPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: 300.0,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController newController) {
                  _onQRViewCreated(newController);
                },
                overlay: QrScannerOverlayShape(
                  borderColor: ColorConst.secondcolor,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: BlocBuilder<QRCodeBloc, QRCodeState>(
              builder: (context, state) {
                if (state is QRCodeLoaded) {
                  return _buildResultDisplay(
                      context, LocaleKeys.Qr_Scanner, state.qrCodeData);
                } else if (state is QRCodeGenerated) {
                  return _buildResultDisplay(
                    context,
                    LocaleKeys.qrdone,
                    state.data,
                  );
                } else {
                  return _buildGenerateButton(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultDisplay(
      BuildContext context, String title, String content) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            SelectableText(content),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: LocaleKeys.qr,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: ColorConst.aftercolor,
              backgroundColor: ColorConst.primarycolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                _generateQRCode(textEditingController.text);
              }
            },
            child: Text(LocaleKeys.qrgen, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _generateQRCode(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.qrdone),
          content: SizedBox(
            width: 200,
            height: 200,
            child: QrImageView(
              data: data,
              version: QrVersions.auto,
              size: 200.0,
              gapless: false,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onQRViewCreated(QRViewController newController) {
    setState(() {
      controller = newController;
    });

    newController.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        BlocProvider.of<QRCodeBloc>(context).add(QRCodeScanned(scanData.code!));
      }
    });
  }
}
