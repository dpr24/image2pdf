class AppImages {
  static String getPath(String filename) {
    return "$basePath/$filename";
  }

  static String basePath = "assets/images";
  static String appLogo = getPath('logo.png');
  static String appLogoPng = getPath('image2pdf.png');
}
