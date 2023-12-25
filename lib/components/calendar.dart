import 'package:sscconnect/models/calendar/appointment-data-source.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CCalendar extends StatelessWidget {
  final List<Appointment>? appointments;
  final List<TimeRegion>? restrictedTime;
  final ValueChanged<CalendarTapDetails> onTap;

  const CCalendar({
    this.appointments,
    this.restrictedTime,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime start = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    );

    return SfCalendar(
      view: CalendarView.week,
      specialRegions: restrictedTime ?? [],
      dataSource: AppointmentDataSource(appointments ?? []),
      todayHighlightColor: primaryColor,
      appointmentBuilder: (
        BuildContext context,
        CalendarAppointmentDetails details,
      ) {
        final Appointment appointment = details.appointments.first;
        int differenceDate = appointment.startTime.diffDate(
          withDate: appointment.endTime,
          type: DiffDateType.minute,
        );
        int hour = (differenceDate / 60).floor();
        int minute = differenceDate - (hour * 60);

        return Container(
          decoration: BoxDecoration(
            color: appointment.color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appointment.subject,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: adaptiveWidthSize(context, 25),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${DateFormat('hh:mm a').format(appointment.startTime)} - ${DateFormat('hh:mm a').format(appointment.endTime)}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: adaptiveWidthSize(context, 22.5),
                ),
              ),
              if (hour != 0)
                Text(
                  "${hour != 0 ? '$hour h ' : ''}${minute != 0 ? '$minute m ' : ''}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: adaptiveWidthSize(context, 22.5),
                  ),
                ),
            ],
          ),
        );
      },
      showDatePickerButton: true,
      showCurrentTimeIndicator: false,
      timeSlotViewSettings: TimeSlotViewSettings(
        numberOfDaysInView: 2,
        startHour: 8,
        endHour: 22,
        timeInterval: Duration(
          minutes: 30,
        ),
        timeRulerSize: adaptiveWidthSize(context, 130),
        timeIntervalHeight: adaptiveWidthSize(context, 100),
        timeFormat: "h:mm a",
        dayFormat: "EEE",
        minimumAppointmentDuration: Duration(
          minutes: 30,
        ),
        timeTextStyle: TextStyle(
          fontSize: adaptiveWidthSize(context, 25),
          color: Colors.black87,
        ),
      ),
      selectionDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          adaptiveWidthSize(context, 5),
        ),
        border: Border.all(
          color: Colors.transparent,
          width: adaptiveWidthSize(context, 5),
        ),
      ),
      showNavigationArrow: true,
      minDate: start,
      onTap: (CalendarTapDetails e) {
        if (e.targetElement.name == "calendarCell") {
          onTap(e);
        }
      },
    );
  }
}
