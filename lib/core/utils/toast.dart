import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_coashing_app/core/utils/color.dart'; // Import AppColors

void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.darkBackground, // Adjust background color to fit app design
    textColor: AppColors.textPrimary, // Adjust text color to fit app design
    fontSize: 16.0,
  );
}