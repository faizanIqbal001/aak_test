import 'package:aak_test/export.dart';

late AppLabels labels;
late AppSizes sizes;
late TextStyles textStyles;
late AppConstants appConstants;

bool _isInitialized = false;

void initializeResources({required BuildContext context}) {
  if (_isInitialized) {
    /// this is to prevent
    /// multiple initialization calls.
    return;
  }

  sizes = AppSizes()..initializeSize(context);
  labels = AppLabels();
  textStyles = TextStyles();
  appConstants = AppConstants();
}
