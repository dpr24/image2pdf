import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image2pdf/components/custom_app_bar.dart';
import 'package:image2pdf/components/custom_text_button.dart';
import 'package:image2pdf/components/loading.dart';
import 'package:image2pdf/components/post_save_dialog.dart';
import 'package:image2pdf/screens/home/home_screen.dart';
import 'package:image2pdf/screens/pdf_screen/bloc/pdf_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  final Uint8List pdfBytes;
  final String password;
  const PdfScreen({super.key, required this.pdfBytes, required this.password});

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      WidgetsFlutterBinding.ensureInitialized();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('bytes len : ${widget.pdfBytes.length}');
    return BlocListener<PdfBloc, PdfState>(
      listener: (context, state) async {
        switch (state) {
          case SettingPasswordToFile():
            Loading.showCirculorDialog();
            break;
          case PdfSaved():
            Get.back();
            Get.offAll(HomeScreen());
            PostSaveDialog.showDialog(state.res);

          default:
        }
      },
      child: BlocBuilder<PdfBloc, PdfState>(
        builder: (context, state) {
          return Scaffold(
              appBar: CustomAppBar(
                title: 'Preview',
                actions: [
                  CustomTextButton(
                      text: 'Save',
                      onClick: () {
                        context.read<PdfBloc>().add(SavePdf(
                            password: widget.password,
                            pdfBytes: widget.pdfBytes));
                      })
                ],
              ),
              body: SfPdfViewer.memory(widget.pdfBytes));
        },
      ),
    );
  }
}
