import 'package:flutter/material.dart';
import 'package:gitfolio/presentation/app/app.dart';
import 'package:gitfolio/presentation/di/injector.dart';

void main() {
  initInjector();
  runApp(const App());
}
