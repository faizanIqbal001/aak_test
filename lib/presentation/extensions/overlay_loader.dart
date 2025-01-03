import 'package:aak_test/export.dart';

enum LoadingState {
  loaded,
  loading,
}

extension ProgressLoader on Stack {
  Widget fullScreenLoader({
    required bool state,
    required Widget loadingWidget,
    required Widget child,
  }) {
    switch (state) {
      case false:
        return Stack(
          children: [
            child,
          ],
        );
      case true:
        return Stack(
          children: [
            child,
            loadingWidget,
          ],
        );
      default:
        return Container();
    }
  }

  Widget fullScreenBlur({
    required bool state,
    required Widget child,
  }) {
    switch (state) {
      case false:
        return Stack(
          children: [
            child,
            Container(
              color: Colors.green,
            ),
          ],
        );
      case true:
        return Stack(
          children: [
            child,
          ],
        );
      default:
        return Container();
    }
  }
}
