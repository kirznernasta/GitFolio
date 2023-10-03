import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitfolio/presentation/di/injector.dart';

final class CubitScope<T extends Cubit> extends StatelessWidget {
  static T of<T extends Cubit>(BuildContext context) => context.read<T>();

  final Widget child;

  const CubitScope({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (_) => i.get<T>(),
      child: child,
    );
  }
}
