import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image2pdf/components/DashedBorderPainter.dart';
import 'package:image2pdf/components/password_setter_dialog.dart';
import 'package:image2pdf/data/constants/app_colors.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';

class PasswordContainer extends StatelessWidget {
  final dynamic size;

  const PasswordContainer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final s = state as HomeInitial;

        return Tooltip(
          textStyle: TextStyle(color: Colors.white),
          decoration: BoxDecoration(color: appColors.appLightColor),
          message: 'set password for PDF',
          child: GestureDetector(
            onTap: () {
              if (s.pdfData != null && s.pdfData!.password != null) {
                context.read<HomeBloc>().add(ClearPassword());
                print('hhh');
              } else {
                PasswordSetterDialog.showPasswordDialog(onSet: (value) {
                  context.read<HomeBloc>().add(SetPassword(password: value));
                });
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
                    AnimatedAlign(
                      duration: Duration(milliseconds: 400),
                      alignment:
                          s.pdfData != null && s.pdfData!.password != null
                              ? Alignment.topRight
                              : Alignment.center,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity:
                            s.pdfData != null && s.pdfData!.password != null
                                ? 1
                                : 0,
                        child: Icon(
                          s.pdfData?.password != null
                              ? Icons.lock_open_rounded
                              : Icons.lock,
                          color: s.pdfData?.password != null
                              ? Colors.red
                              : appColors.appLightColor,
                        ),
                      ),
                    ),
                    AnimatedAlign(
                      duration: Duration(milliseconds: 400),
                      alignment:
                          // s.pdfData != null && s.pdfData!.password != null
                          //     ? Alignment.topRight
                          //     :
                          Alignment.center,
                      child: Icon(
                        s.pdfData?.password != null
                            ? Icons.lock
                            : Icons.lock_open_rounded,
                        color: s.pdfData?.password != null
                            ? Colors.green
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
