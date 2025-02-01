import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';
import 'package:image2pdf/utils/pdf/pdf_generator.dart';

part 'pdf_event.dart';
part 'pdf_state.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final HomeBloc homeBloc;

  PdfBloc(this.homeBloc) : super(PdfInitial()) {
    on<SavePdf>((event, emit) async {
      if (state is PdfInitial) {
        try {
          emit(SettingPasswordToFile(event.pdfBytes, event.password));
          final encryptedBytes = await compute(PdfGenerator.encryptPdf,
              {'bytes': event.pdfBytes, 'password': event.password});

          final res = await PdfGenerator.savePdf(encryptedBytes);

          emit(PdfSaved(res));
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
