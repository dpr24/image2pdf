import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image2pdf/components/DashedBorderPainter.dart';
import 'package:image2pdf/data/constants/app_colors.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';

class OverlayContainer extends StatelessWidget {
  final dynamic size;

  const OverlayContainer({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final s = state as HomeInitial;

        return Tooltip(
          textStyle: TextStyle(color: Colors.white),
          decoration: BoxDecoration(color: appColors.appLightColor),
          message: 'Overlay Image',
          child: GestureDetector(
            onTap: () {
              if (s.pdfData != null && s.pdfData!.overlayImage != null) {
                context.read<HomeBloc>().add(ClearOverlayImage());
              } else {
                context.read<HomeBloc>().add(PickOverlayImage());
              }
            },
            child: CustomPaint(
              painter: DashedBorderPainter(),
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    if (s.pdfData != null && s.pdfData!.overlayImage != null)
                      Image.file(File(s.pdfData!.overlayImage!.path)),
                    AnimatedAlign(
                      duration: Duration(milliseconds: 400),
                      alignment:
                          s.pdfData != null && s.pdfData!.overlayImage != null
                              ? Alignment.topRight
                              : Alignment.center,
                      child: Icon(
                        s.pdfData?.overlayImage != null
                            ? Icons.remove_circle_outline_outlined
                            : Icons.image,
                        color: s.pdfData?.overlayImage != null
                            ? Colors.red
                            : appColors.appLightColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
