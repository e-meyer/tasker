import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/constants.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.trailing,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String title;
  final Widget? trailing;

  @override
  final Size preferredSize;

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: kLightBlue),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: SvgPicture.asset(
                'assets/icons/arrow-back-icon.svg',
                height: 20,
              ),
            ),
          ),
        ),
      ),
      actions: [
        widget.trailing != null ? widget.trailing! : Container(),
      ],
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
