import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/constants.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.refresh});

  final Function refresh;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (string) => widget.refresh(string),
            cursorColor: kPrimaryColor,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: kSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: kLightBlue,
                ),
              ),
              hintText: 'Search for a title',
              hintStyle: GoogleFonts.poppins(
                color: kDarkGrey,
                fontSize: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: kLightBlue,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              isDense: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  'assets/icons/search-icon.svg',
                  color: kDarkGrey,
                ),
              ),
              filled: true,
              fillColor: kMainBackground,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 0,
          child: InkWell(
            onTap: () {
              showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then(
                (value) => setState(
                  () {
                    if (value != null) {
                      widget.refresh('',
                          firstDate: value.start, secondDate: value.end);
                    }
                  },
                ),
              );
            },
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kPrimaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                  'assets/icons/calendar-icon.svg',
                  height: 25,
                  color: kMainBackground,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}