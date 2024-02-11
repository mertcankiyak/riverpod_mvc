import 'package:flutter/material.dart';

class GeneralRadius extends BorderRadius {
  const GeneralRadius.all(super.radius) : super.all();
  const GeneralRadius.authTextFieldRadius()
      : super.all(const Radius.circular(10));
}
