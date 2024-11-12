import 'package:flutter/material.dart';
import 'package:team_sphere_mobile/app/themes/themes.dart';

import 'widgets.dart';

Future<void> showCircleLoadingDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: TSColors.shades.hiEm.withOpacity(0.3),
    builder: (context) {
      return Center(
        child: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircularProgressIndicator(
            color: TSColors.primary.p100,
            strokeWidth: 5,
          ),
        ),
      );
    },
  );
}


Future<T?> showSheet<T>(
  context, {
  bool? isScrollControlled,
  Widget? child,
  Color? backgroundColor,
  EdgeInsets? contentPadding,
  bool? barrierDismissible = true,
  bool? enableDrag = true,
  bool? isDismissible = true,

    }) {
  return showModalBottomSheet<T>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    isScrollControlled: isScrollControlled ?? false,
    backgroundColor: TSColors.background.b100,
    enableDrag: enableDrag ?? true,
    isDismissible:isDismissible ?? true ,
    constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - (kToolbarHeight)),
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: Container(
              padding: contentPadding,
              color: backgroundColor ?? TSColors.background.b100,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  barrierDismissible ?? true ? Container(
                    height: 4,
                    width: 62,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: TSColors.shades.stroke,
                    ),
                  ) :Container(),
                  if (child != null) Flexible(child: child),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

// Future<DateTime?> showPDatePicker(
//   BuildContext context, {
//   required DateTime initialDate,
//   required DateTime firstDate,
//   required DateTime lastDate,
// }) {
//   return showSheet<DateTime>(context,
//       backgroundColor: PColors.background.b100,
//       contentPadding: EdgeInsets.zero,
//       child: Calendar(
//         firstDate: firstDate,
//         initialDate: initialDate,
//         lastDate: lastDate,
//       ));
// }

// Future<DateTime?> showPDatePickerOldV2(
//     BuildContext context, {
//       required DateTime initialDate,
//       required DateTime firstDate,
//       required DateTime lastDate,
//     }) {
//   return showSheet<DateTime>(context,
//       backgroundColor: PColors.background.b100,
//       contentPadding: EdgeInsets.zero,
//       child: Calendar.v2(
//         firstDate: firstDate,
//         initialDate: initialDate,
//         lastDate: lastDate,
//       ));
// }

// Future<DateTime?> showPDatePickerV2(
//   BuildContext context, {
//   required DateTime initialDate,
//   required DateTime firstDate,
//   required DateTime lastDate,
// }) {
//   return showSheet<DateTime>(context,
//       backgroundColor: PColors.background.b100,
//       contentPadding: EdgeInsets.zero,
//       child: CalendarV2(
//         firstDate: firstDate,
//         initialDate: initialDate,
//         lastDate: lastDate,
//       ));
// }

// Future<TimeOfDay?> showPTimePicker(
//   BuildContext context, {
//   required TimeOfDay initialTime,
// }) {
//   return showSheet<TimeOfDay?>(context,
//       backgroundColor: PColors.background.b100,
//       contentPadding: EdgeInsets.zero,
//       child: TimePicker(
//         initialTime: initialTime,
//       ));
// }

// Future<TimeOfDay?> showPTimePickerV2(
//     BuildContext context, {
//       required TimeOfDay initialTime,
//     }) {
//   return showSheet<TimeOfDay?>(context,
//       backgroundColor: PColors.background.b100,
//       contentPadding: EdgeInsets.zero,
//       child: TimePicker.v2(
//         initialTime: initialTime,
//       ));
// }

Future<void> showAlertDialog(
  BuildContext context, {
  List<Button> buttons = const [],
  required String title,
  required String description,
      bool? barrierDismissible
}) {
  return showDialog(
    context: context,
    barrierDismissible:barrierDismissible ??true,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SubHeadline.bold(title,
                  color: TSColors.shades.loEm, textAlign: TextAlign.center),
              Body1.regular(description,
                  color: TSColors.shades.loEm, textAlign: TextAlign.center),
              if (buttons.isNotEmpty) ...[
                const Divider(thickness: 1),
                SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buttons.map((e) => e).toList(),
                  ),
                )
              ]
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showLinearProgressDialog(BuildContext context,
    {required String title}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Body1(title),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                color: TSColors.alert.green700,
                backgroundColor: TSColors.alert.green100,
              ),
            ],
          ),
        ),
      );
    },
  );
}
