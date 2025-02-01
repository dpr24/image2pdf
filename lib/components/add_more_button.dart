import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image2pdf/components/DashedBorderPainter.dart';
import 'package:image2pdf/data/constants/app_colors.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';

class AddMoreButton extends StatelessWidget {
  final dynamic size;

  const AddMoreButton({
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
          message: 'Add Image',
          child: AnimatedPadding(
            padding: state.isMinimized
                ? const EdgeInsets.all(3.0)
                : EdgeInsets.only(left: 0, right: 0),
            duration: Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(PickMoreImages());
              },
              child: CustomPaint(
                painter: DashedBorderPainter(),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: size,
                  height: state.isMinimized ? size : size * 2,
                  alignment: Alignment.center,
                  child: Center(
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
