import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cripto_qr_googlemarine/utils/theme.dart';
import 'package:cripto_qr_googlemarine/utils/ui/colors.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/src/image.dart' as src;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/user.dart';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:image/image.dart' as img;

class HomeWidget extends StatelessWidget {
  final User user;
  final String encrypted;

  HomeWidget({Key? key, required this.user, required this.encrypted})
      : super(key: key);

  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CQColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RepaintBoundary(
                key: globalKey,
                child: Card(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 16, 0, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(user.name,
                                  style: CQTheme.h1.copyWith(
                                    fontSize: 10,
                                  )),
                              Text(
                                user.role,
                                style: CQTheme.h2.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                user.company,
                                style: CQTheme.h3.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                user.number.toString(),
                                style: CQTheme.h1.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                user.checkInValidation,
                                style: CQTheme.subhead1.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: QrImageView(
                            data: encrypted,
                            version: QrVersions.auto,
                            size: 300.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //show generated png image from convertWidgetToImage function
              ElevatedButton(
                onPressed: () {
                  convertWidgetToImage();
                },
                child: const Text(
                  'Convert Widget to Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              QrImageView(
                data: encrypted,
                version: QrVersions.auto,
                size: 600.0,
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(user.email),
              ),
              ListTile(
                title: const Text('Identidade'),
                subtitle: Text(user.identity),
              ),
              ListTile(
                title: const Text('Embarcação'),
                subtitle: Text(user.vessel),
              ),
              ListTile(
                title: const Text('ASO'),
                subtitle: Text(user.aso.toString()),
              ),
              ListTile(
                title: const Text('NR10'),
                subtitle: Text(user.nr10.toString()),
              ),
              ListTile(
                title: const Text('Email'),
                subtitle: Text(user.email),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> convertWidgetToImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Get the device's pixel ratio
      final double devicePixelRatio =
          MediaQuery.of(globalKey.currentContext!).devicePixelRatio;

      // Convert mm to inches (1 inch = 25.4 mm)
      //    final double heightInInches = 63 / 25.4;
      const double widthInInches = 85 / 25.4;

      // Calculate the target dimensions in pixels
      //   final double targetHeightInPixels = heightInInches *
      //     devicePixelRatio *
      //    96; // 96 is the DPI for flutter in most cases
      final double targetWidthInPixels = widthInInches * devicePixelRatio * 96;

      ui.Image image = await boundary.toImage(
          pixelRatio: targetWidthInPixels / boundary.size.width);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //present image in dialog
      showDialog(
        context: globalKey.currentContext!,
        builder: (context) => AlertDialog(
          content: Image.memory(pngBytes),
        ),
      );

      final Image pngImage = Image.memory(pngBytes);

      printPngImage(pngBytes);

      final result =
          await ImageGallerySaver.saveImage(pngBytes.buffer.asUint8List());
      print(result);

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      return users
          .add(user.toMap())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      // Now pngBytes contains the PNG image data with dimensions close to 63mm x 85mm.
      // You can write it to a file or do something else with it.

      //save to gallery
    } catch (e) {
      print(e);
    }
  }

  Future<void> printPngImage(Uint8List pngBytes) async {
    final profile = await CapabilityProfile.load();

    final printer = NetworkPrinter(PaperSize.mm80, profile);

    final connect = await printer.connect('192.168.0.123', port: 9100);

    printer.cut();
    printer.disconnect();
  }
}
