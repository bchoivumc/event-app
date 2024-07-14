import 'dart:ui';

import 'package:event_app/app/configs/colors.dart';
import 'package:event_app/data/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardPopularEvent extends StatelessWidget {
  final EventModel eventModel;

  const CardPopularEvent({required this.eventModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 240,
      margin: const EdgeInsets.only(left: 12, right: 12),
      child: Stack(
        children: [
          _buildCardImage(context),
          _buildCardDesc(),
        ],
      ),
    );
  }

  _buildCardImage(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 240,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.network(
                eventModel.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ],
          ),
        ),
      );

  _buildCardDesc() => Positioned(
      bottom: 40,
      right: 9,
      left: 9,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            height: 90,
            color: Colors.black.withOpacity(0.25),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        eventModel.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       'assets/images/location.svg',
                    //       width: 20,
                    //     ),
                    //     const SizedBox(width: 6),
                    //     Text(
                    //       eventModel.location,
                    //       style: const TextStyle(
                    //         fontSize: 13,
                    //         color: AppColors.whiteColor,
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
                // Container(
                //   height: 50,
                //   width: 50,
                //   decoration: BoxDecoration(
                //     color: AppColors.whiteColor,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       // Text(
                //       //   eventModel.date.split(" ")[0],
                //       //   style: const TextStyle(
                //       //     fontSize: 14,
                //       //     fontWeight: FontWeight.w600
                //       //   ),
                //       // ),
                //       ConstrainedBox(
                //         constraints: const BoxConstraints(maxWidth: 40),
                //         child: Text(
                //           eventModel.date.split(",")[1],
                //           style: const TextStyle(
                //             fontSize: 8,
                //               color: AppColors.primaryColor,
                //               fontWeight: FontWeight.w600),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ));
}
