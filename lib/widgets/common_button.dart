import 'package:aak_test/export.dart';

class CommonButton extends StatelessWidget {
  final Function? onPressed;
  final String label;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final Widget? widget;
  final double? fontSize;
  final double? height;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.isLoading,
    this.color,
    this.textColor = Colors.white,
    this.widget,
    this.fontSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed!(),
      child: Container(
        width: sizes.width,
        height: height ?? sizes.heightRatio * 50,
        decoration: BoxDecoration(
          color: color ?? Colors.blueAccent,
          borderRadius: BorderRadius.circular(
            58.0,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: sizes.widthRatio * 40,
                height: sizes.heightRatio * 40,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Center(
                  child: widget ??
                      Text(
                        label,
                        style: textStyles.semiBold.copyWith(
                          color: textColor,
                          fontSize: fontSize ?? sizes.fontRatio * 18,
                        ),
                      ),
                ),
              ),
      ),
    );
  }
}
