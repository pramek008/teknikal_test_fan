import 'package:flutter/material.dart';
import 'package:test_teknikal_fan/utils/theme.dart';

class InformationTileWidget extends StatelessWidget {
  const InformationTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.authStatus,
    this.onTap,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;
  final bool? authStatus;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
                SizedBox(
                  width: 24,
                ),
                Text(
                  title!,
                  style: txMedium.copyWith(
                    color: blackColor,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                authStatus != null
                    ? authStatus!
                        ? Icon(
                            Icons.check_box_rounded,
                            color: primaryColor,
                            size: 30,
                          )
                        : TextButton(
                            onPressed: onTap,
                            style: TextButton.styleFrom(
                              backgroundColor: redColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Verify Email',
                              style: txSemiBold.copyWith(
                                color: whiteColor,
                                fontSize: 14,
                              ),
                            ),
                          )
                    : SizedBox(),
              ],
            ),
          ),
          Divider(
            color: greyColor,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
