import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tasker/layers/core/utils/constants.dart';

class ManageTaskDateWidget extends StatefulWidget {
  ManageTaskDateWidget({
    super.key,
    required this.dateTime,
    required this.refresh,
  });

  DateTime dateTime;
  Function refresh;

  @override
  State<ManageTaskDateWidget> createState() => _ManageTaskDateWidgetState();
}

class _ManageTaskDateWidgetState extends State<ManageTaskDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat("MMMM").format(widget.dateTime)}, ${widget.dateTime.day}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
                fontSize: 25,
              ),
            ),
            Text(
              '${widget.dateTime.year}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                color: kDarkGrey,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: kLightBlue),
            color: kPrimaryColor,
          ),
          child: InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: widget.dateTime != DateTime.now()
                    ? widget.dateTime
                    : DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then(
                (value) => setState(
                  () {
                    if (value != null) {
                      widget.dateTime = value;
                      widget.refresh(value);
                    }
                  },
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: SvgPicture.asset(
                'assets/icons/calendar-icon.svg',
                height: 25,
                color: kMainBackground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
