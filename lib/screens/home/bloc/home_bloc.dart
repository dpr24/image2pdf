import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:image2pdf/screens/home/model/pdf_data.dart';
import 'package:image2pdf/utils/image_picker_manager.dart';
import 'package:image2pdf/utils/pdf/pdf_generator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ToggleImageContainer>((event, emit) async {
      final cState = state as HomeInitial;

      final updatedState = cState.copyWith(
          isMinimized: !cState.isMinimized, pickedImages: cState.pickedImages);
      await Future.delayed(Duration(milliseconds: 300), () {});

      emit(updatedState);
      print(updatedState.isMinimized);
    });

    on<HomeButtonClick>((event, emit) async {
      final currentState = state as HomeInitial;

      final loadingState = currentState.copyWith(isLoadingImages: true);
      emit(loadingState);
      if (currentState.pickedImages.isEmpty) {
        final images = await ImagePickerManager.pickMultipleImages();
        final s = state as HomeInitial;

        final newState =
            s.copyWith(pickedImages: images, isLoadingImages: false);
        emit(newState);
      } else {
        final newState = currentState.copyWith(isProcessing: true);

        emit(newState);

        if (newState.pdfData != null) {
          final data =
              newState.pdfData!.copyWith(images: newState.pickedImages);
          final pdfbytes = await PdfGenerator.generatePdf(data: data);
          final s = currentState.copyWith(
              isProcessing: false, isLoadingImages: false);

          if (pdfbytes.isNotEmpty) {
            if (data.password != null && data.password!.isNotEmpty) {
              emit(NavigateToPdfScreen(pdfbytes, data.password!));
            } else {
              await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => pdfbytes)
                  .then((doc) {});
            }
          }

          emit(s);
        } else {
          final data = PdfData(images: newState.pickedImages);
          final pdfbytes = await PdfGenerator.generatePdf(data: data);
          final s = currentState.copyWith(
              isProcessing: false, isLoadingImages: false);
          if (data.password != null && data.password!.isNotEmpty) {
            print('fffff');
            emit(NavigateToPdfScreen(pdfbytes, data.password!));
          } else {
            await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => pdfbytes)
                .then((doc) {});
          }
          emit(s);
        }
      }
    });

    on<PickMoreImages>((event, emit) async {
      final images = await ImagePickerManager.pickMultipleImages();
      final s = state as HomeInitial;
      final loadingState = s.copyWith(isLoadingImages: true);
      emit(loadingState);
      s.pickedImages.addAll(images);

      final newState =
          s.copyWith(pickedImages: s.pickedImages, isLoadingImages: false);
      emit(newState);
    });

    on<PickOverlayImage>((event, emit) async {
      final pickedImage = await ImagePickerManager.pickImage();
      final s = state as HomeInitial;
      if (s.pdfData != null) {
        final data = s.pdfData!.copyWith(overlay: pickedImage);
        final newState = s.copyWith(pdfdata: data);
        emit(newState);
      } else {
        final data = PdfData(images: s.pickedImages, overlayImage: pickedImage);
        final newState = s.copyWith(pdfdata: data);
        emit(newState);
      }
    });
    on<RemoveImageFromList>((event, emit) async {
      final s = state as HomeInitial;

      List<XFile> updatedItems = List.from(s.pickedImages)
        ..removeAt(event.position);

      final newState = s.copyWith(pickedImages: updatedItems);
      emit(newState);

      print(newState.pickedImages.length);
    });

    on<Reset>((event, emit) async {
      final s = state as HomeInitial;
      final pdfData = s.pdfData!
          .copyWith(images: [], setPasswordNull: true, setOverlayNull: true);

      final newState = s.copyWith(
          pickedImages: [],
          pdfdata: pdfData,
          isMinimized: true,
          isProcessing: false);
      emit(newState);

      print(newState.pickedImages.length);
    });

    on<ClearOverlayImage>((event, emit) async {
      final s = state as HomeInitial;

      final data = s.pdfData!.copyWith(setOverlayNull: true);

      final newState = s.copyWith(pdfdata: data);
      emit(newState);
    });

    on<ListReorderEvent>((event, emit) async {
      final s = state as HomeInitial;
      final updatedItems = List<XFile>.from(s.pickedImages);
      int nv = event.newValue!;
      int ov = event.old!;

      // Adjust newIndex if it's pointing to the "Add More" button
      if (nv > updatedItems.length) {
        nv = updatedItems.length;
      }

      if (nv > ov) nv--;

      final item = updatedItems.removeAt(ov);
      updatedItems.insert(nv, item);

      final newState = s.copyWith(pickedImages: updatedItems);
      emit(newState);
    });

    on<SetPassword>((event, emit) async {
      final s = state as HomeInitial;
      if (s.pdfData != null) {
        final data = s.pdfData!
            .copyWith(images: s.pickedImages, password: event.password);

        final newState = s.copyWith(pdfdata: data);
        emit(newState);
      } else {
        final data = s.pdfData =
            PdfData(images: s.pickedImages, password: event.password);

        final newState = s.copyWith(pdfdata: data);
        emit(newState);
        print(newState.pdfData!.password);
      }
    });
    on<ClearPassword>((event, emit) async {
      final s = state as HomeInitial;
      final pdfData = s.pdfData!.copyWith(setPasswordNull: true);

      final newState = s.copyWith(pdfdata: pdfData);
      emit(newState);
      print(newState.pdfData!.password);
    });
  }
}
