import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A [GetBuilder] with a [listener].
///
/// This is a shorter way to add a listener without having to cache it
/// in the controller and saves you a lot of boilerplate.
class GetConsumer<T extends GetxController> extends GetBuilder<T> {
  final void Function(T) listener;

  GetConsumer({
    Key? key,
    required T controller,
    bool global = true,
    required Widget Function(T) builder,
    required this.listener,
    bool autoRemove = true,
    bool assignId = false,
    void Function(GetBuilderState<T>)? initState,
    Object Function(T)? filter,
    String? tag,
    void Function(GetBuilderState<T>)? dispose,
    Object? id,
    void Function(GetBuilderState<T>)? didChangeDependencies,
    void Function(GetBuilder<GetxController>, GetBuilderState<T>)?
        didUpdateWidget,
  }) : super(
          key: key,
          init: controller,
          global: global,
          builder: builder,
          autoRemove: autoRemove,
          assignId: assignId,
          id: id,
          didChangeDependencies: didChangeDependencies,
          didUpdateWidget: didUpdateWidget,
          filter: filter,
          tag: tag,
          initState: (state) {
            final consumerState = (state as GetConsumerState<T>);

            state._listener = () => listener(controller);

            controller.addListener(consumerState._listener);

            if (initState != null) initState(state);
          },
          dispose: (state) {
            final consumerState = (state as GetConsumerState<T>);

            controller.removeListener(consumerState._listener);

            if (dispose != null) dispose(state);
          },
        );

  @override
  GetBuilderState<T> createState() => GetConsumerState<T>();
}

class GetConsumerState<T extends GetxController> extends GetBuilderState<T> {
  late final VoidCallback _listener;
}
