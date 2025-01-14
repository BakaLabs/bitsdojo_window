// ignore_for_file: depend_on_referenced_packages, avoid_single_cascade_in_expression_statements

import 'package:bitsdojo_window_windows/bitsdojo_window_windows.dart'
    show WinDesktopWindow;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../app_window.dart';

class WindowBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? width;

  const WindowBorder({Key? key, required this.child, required this.color, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWindowsApp =
        (!kIsWeb) && (defaultTargetPlatform == TargetPlatform.windows);
    bool isLinuxApp =
        (!kIsWeb) && (defaultTargetPlatform == TargetPlatform.linux);

    // Only show border on Windows and Linux
    if (!(isWindowsApp || isLinuxApp)) {
      return child;
    }

    var borderWidth = width ?? 1;
    var topBorderWidth = width ?? 1;

    if (appWindow is WinDesktopWindow) {
      appWindow as WinDesktopWindow..setWindowCutOnMaximize(borderWidth.ceil());
    }

    if (isWindowsApp) {
      topBorderWidth += 1 / appWindow.scaleFactor;
    }
    final topBorderSide = BorderSide(color: color, width: topBorderWidth);
    final borderSide = BorderSide(color: color, width: borderWidth);

    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: topBorderSide,
                left: borderSide,
                right: borderSide,
                bottom: borderSide)),
        child: child);
  }
}
