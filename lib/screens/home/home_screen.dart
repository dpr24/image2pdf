import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image2pdf/components/add_more_button.dart';
import 'package:image2pdf/components/custom_app_bar.dart';
import 'package:image2pdf/components/custom_text_button.dart';
import 'package:image2pdf/components/loading.dart';
import 'package:image2pdf/components/overlay_container.dart';
import 'package:image2pdf/components/password_container.dart';
import 'package:image2pdf/data/constants/app_colors.dart';
import 'package:image2pdf/data/constants/app_strings.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';
import 'package:image2pdf/screens/pdf_screen/pdf_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case HomeInitial():
            switch (state.isLoadingImages) {
              case true:
                Loading.showLoadingDialog();
                break;
              case false:
                Get.back();
                break;
            }
            break;
          case NavigateToPdfScreen():
            WidgetsBinding.instance.addPostFrameCallback((_) {
              print('home : ${state.pdfBytes.length}');
              Get.to(PdfScreen(
                  pdfBytes: state.pdfBytes, password: state.password));
            });
            break;
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return PopScope(
            // onPopInvokedWithResult: (didPop, result) {
            //   if (state is HomeInitial) {
            //     switch (state.isMinimized) {
            //       case true:
            //         break;
            //       case false:
            //         context.read<HomeBloc>().add(ToggleImageContainer());
            //         break;
            //     }
            //   }
            // },
            // canPop: state is HomeInitial && state.isMinimized,
            child: Scaffold(
                appBar: CustomAppBar(
                  title: AppStrings.appname,
                ),
                body: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      if (state is HomeInitial) ...[
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            if (state.pickedImages.isNotEmpty) ...[
                              OverlayContainer(size: 60.0),
                              PasswordContainer(size: 60.0)
                            ],
                            CustomTextButton(
                              text: state.pickedImages.isNotEmpty
                                  ? "Generate PDF"
                                  : 'Pick Images',
                              onClick: () {
                                context.read<HomeBloc>().add(HomeButtonClick());
                              },
                              isLoading: state.isProcessing,
                            ),
                          ],
                        ),
                        Spacer(),
                        if (state.pickedImages.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: state.isMinimized
                                  ? Get.height / 4.5
                                  : Get.height - 200,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: appColors.appLightColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            context
                                                .read<HomeBloc>()
                                                .add(ToggleImageContainer());
                                          },
                                          icon: Icon(
                                            state.isMinimized
                                                ? Icons.fullscreen
                                                : Icons.minimize,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: !state.isMinimized
                                          ? const EdgeInsets.only(
                                              left: 100.0,
                                              right: 100,
                                            )
                                          : EdgeInsets.all(3),
                                      child: ReorderableListView.builder(
                                          scrollDirection: state.isMinimized
                                              ? Axis.horizontal
                                              : Axis.vertical,
                                          itemBuilder: (context, index) {
                                            if (index ==
                                                state.pickedImages.length) {
                                              return SizedBox(
                                                  key: ValueKey(index),
                                                  child: AddMoreButton(
                                                      size: 60.0));
                                            } else {
                                              return Padding(
                                                key: ValueKey(state.pickedImages
                                                    .elementAt(index)),
                                                padding: !state.isMinimized
                                                    ? const EdgeInsets.only(
                                                        // left: 100.0,
                                                        // right: 100,
                                                        )
                                                    : EdgeInsets.all(3),
                                                child: Dismissible(
                                                  direction: state.isMinimized
                                                      ? DismissDirection.up
                                                      : DismissDirection
                                                          .horizontal,
                                                  background: Container(
                                                    color:
                                                        appColors.appDarkColor,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  onDismissed: (direction) {
                                                    if (direction == DismissDirection.endToStart ||
                                                        direction ==
                                                            DismissDirection
                                                                .startToEnd ||
                                                        direction ==
                                                            DismissDirection
                                                                .up) {
                                                      context
                                                          .read<HomeBloc>()
                                                          .add(
                                                              RemoveImageFromList(
                                                                  position:
                                                                      index));
                                                    }
                                                  },
                                                  key: ValueKey(state
                                                      .pickedImages
                                                      .elementAt(index)),
                                                  child: Container(
                                                    margin: EdgeInsets.all(2),
                                                    color:
                                                        appColors.appLightColor,
                                                    child: Stack(
                                                      children: [
                                                        Image.file(File(state
                                                            .pickedImages[index]
                                                            .path)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          itemCount:
                                              state.pickedImages.length + 1,
                                          onReorder: (oldIndex, newIndex) {
                                            context.read<HomeBloc>().add(
                                                  ListReorderEvent(
                                                      old: oldIndex,
                                                      newValue: newIndex),
                                                );
                                          }),
                                    ),
                                  ),
                                  if (state.pickedImages.length > 10)
                                    CustomTextButton(
                                        text: 'add more',
                                        leadIcon: Icons.add_box_rounded,
                                        onClick: () {
                                          context
                                              .read<HomeBloc>()
                                              .add(PickMoreImages());
                                        })
                                ],
                              ),
                            ),
                          )
                      ]
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
