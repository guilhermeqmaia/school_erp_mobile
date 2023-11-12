import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final Widget child;
  final bool refresh;
  final Future<void> Function()? onRefresh;
  const LayoutWidget({
    super.key,
    required this.child,
    this.refresh = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        ).wrapWithRefreshIndicator(
          refresh,
          onRefresh ?? () async {},
        );
      },
    );
  }
}

extension _RefreshIndicator on Widget {
  Widget wrapWithRefreshIndicator(
      bool refresh, Future<void> Function() onRefresh) {
    return refresh
        ? RefreshIndicator(
            onRefresh: onRefresh,
            color: Colors.orange.shade400,
            child: this,
          )
        : this;
  }
}
