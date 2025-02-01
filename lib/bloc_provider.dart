import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';
import 'package:image2pdf/screens/pdf_screen/bloc/pdf_bloc.dart';

class AppBlocProvider {
  static getAppBlocProviders() {
    return [
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      ),
      BlocProvider<PdfBloc>(
        create: (context) => PdfBloc(HomeBloc()),
      )
    ];
  }
}
