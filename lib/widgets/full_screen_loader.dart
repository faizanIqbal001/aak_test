import 'dart:ui';

import 'package:aak_test/export.dart';

Widget fullScreenLoader() => Material(
      color: Colors.black.withOpacity(0.2),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: InkWell(
          onTap: () {},
          splashColor: Colors.white.withOpacity(0.0),
          hoverColor: Colors.white.withOpacity(0.0),
          highlightColor: Colors.white.withOpacity(0.0),
          child: SizedBox(
            width: sizes.width,
            height: sizes.height,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
              ),
            ),
          ),
        ),
      ),
    );
