import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magical_walls/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

const Duration errorMessageDisplayDuration = Duration(milliseconds: 3000);
Future<void> showCustomSnackBar({
  required BuildContext context,
  required String errorMessage,
   Color? backgroundColor,
  Duration delayDuration = errorMessageDisplayDuration,
}) async {
  var overlayState = Overlay.of(context);
  var overlayEntry = OverlayEntry(
    builder: (context) => ErrorMessageOverlayContainer(
      backgroundColor: CommonColors.primaryColor,
      errorMessage: errorMessage,
    ),
  );

  overlayState.insert(overlayEntry);
  await Future.delayed(delayDuration);
  overlayEntry.remove();
}

class ErrorMessageOverlayContainer extends StatefulWidget {
  final String errorMessage;
  final Color backgroundColor;
  const ErrorMessageOverlayContainer({
    Key? key,
    required this.errorMessage,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<ErrorMessageOverlayContainer> createState() =>
      _ErrorMessageOverlayContainerState();
}

class _ErrorMessageOverlayContainerState
    extends State<ErrorMessageOverlayContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  late Animation<double> slideAnimation = Tween<double>(begin: -0.5, end: 1.0)
      .animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOutCirc,
        ),
      );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000 - 500), () {
      animationController.reverse();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            PositionedDirectional(
              start: MediaQuery.of(context).size.width * 0.1,
              bottom: MediaQuery.of(context).size.height * 0.095 * slideAnimation.value,
              child: Opacity(
                opacity: slideAnimation.value < 0.0 ? 0.0 : slideAnimation.value,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      widget.errorMessage,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


class Utils {
  static Future<void> makePhoneCall({required String phoneNumber, required
  BuildContext context}) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      if(context.mounted == true) {
        showCustomSnackBar(context: context, errorMessage: "Try Again");
      }
    }
  }


  static String filterMonthYearInDate(String dateStr) {
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('MMMM yyyy').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }


  static String formatDateTimeInHoursDifference(String isoDate) {
    try {
      DateTime inputTime = DateTime.parse(isoDate).toLocal();
      DateTime now = DateTime.now();
      Duration diff = now.difference(inputTime);
      if (diff.inDays < 1) {
        if (diff.inHours >= 1) {
          return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
        } else if (diff.inMinutes >= 1) {
          return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
        } else {
          return 'Just now';
        }
      }

      // 1 day or more → show date & time
      return DateFormat('dd, hh:mm a').format(inputTime);
    }catch (e){
      return isoDate;
    }
  }
}