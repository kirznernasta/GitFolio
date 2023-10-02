import 'package:flutter/material.dart';
import 'package:gitfolio/presentation/base/base_cubit.dart';
import 'package:gitfolio/presentation/di/injector.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState();
}

abstract class BasePageState<P extends BasePage, C extends BaseCubit>
    extends State<P> {
  @protected
  final cubit = i.get<C>();

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.dispose();
  }
}
