import 'package:auth_weather_api/util/validators/validation.dart';
import 'package:flutter/widgets.dart';

class Validator {
  Validator._();
  //applies a list of validations to the form field values
  static FormFieldValidator<T> apply<T>(BuildContext context, List<Validation<T>> validations){
    return (T? value) {
      for (final validation in validations) {
        final error = validation.validate(context, value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
