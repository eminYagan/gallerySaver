import 'package:flutter/material.dart';
import 'package:gallery_saver/imports.dart';

class TimeService{

  final import = Imports();

  //Tarih ve saat seçme fonksiyonu.
  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    DateTime? selectedDate;

    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((date) async {
      if (date != null) {
        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate),
        ).then((time) async {
          if (time != null) {
            DateTime selectedDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

            await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: selectedDateTime,
              lastDate: lastDate,
            ).then((secondDate) async {
              if (secondDate != null) {
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                ).then((secondTime) {
                  if (secondTime != null) {
                    import.mainController.startDate = selectedDateTime;
                    import.mainController.endDate = DateTime(secondDate.year, secondDate.month, secondDate.day, secondTime.hour, secondTime.minute);
                  }
                });
              }
            });
          }
        });
      }
    });

    return selectedDate;
  }

  Future<void> selectDateAndTime(BuildContext context) async {
    await showDateTimePicker(
      context: context,
      initialDate: import.mainController.startDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
  }
}