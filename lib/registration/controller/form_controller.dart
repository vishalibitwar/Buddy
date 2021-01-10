import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/form.dart';

class FormController {
  final void Function(String) callback;

  static const String URL =
      "https://script.google.com/macros/s/AKfycbzwUhbrz7uNpTG5Kssrr5Uz2H-ti4O-JFxX1RgtLVtEaFpMnHC1dMx_/exec";

  static const STATUS_SUCESS = "SUCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      await http.get(URL + feedbackForm.toParams()).then((res) {
        callback(convert.jsonDecode(res.body)['status']);
      });
    } catch (error) {
      print(error);
    }
  }
}
