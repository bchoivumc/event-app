//import 'dart:js';

import 'package:card_swiper/card_swiper.dart';
import 'package:event_app/app/configs/colors.dart';
import 'package:event_app/app/resources/constant/named_routes.dart';
import 'package:event_app/bloc/event_cubit.dart';
import 'package:event_app/controllers/Home%20Page%20controllers/location_controller.dart';
import 'package:event_app/data/event_model.dart';
import 'package:event_app/models/Home%20page%20models/locationModel.dart';
import 'package:event_app/ui/pages/profile_page.dart';
import 'package:event_app/ui/widgets/card_event_this_month.dart';
import 'package:event_app/ui/widgets/card_popular_event.dart';
import 'package:event_app/ui/widgets/custom_app_bar.dart';
import 'package:event_app/ui/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signals/signals_flutter.dart';

import 'view_all_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String address_locality = "";
  String address_country = "";

  late LocationController _controller;
  late locationModel lc;
  // adding pos.latitude, pos.longitude
  double current_latitude = 0;
  double current_longitude = 0;
  var BottomNav = signal(MyNavigationBar(0, 0));

  @override
  void initState() {
    super.initState();
    _controller = LocationController();
    lc = locationModel(country: "", locality: "", latitude: 0, longitude: 0);
    _updateLocation();
  }

  Future<void> _updateLocation() async {
    try {
      lc = await _controller.getCurrentLocation();
      setState(() {
        address_locality = lc.locality;
        address_country = lc.country;
        current_latitude = lc.latitude;
        current_longitude = lc.longitude;
        BottomNav.value = MyNavigationBar(current_latitude, current_longitude);
        // print(
        //     'current location HOME lat: $current_latitude and lon: $current_longitude and locality: ${lc.locality}');
      });
    } catch (e) {
      print('Error updating location: $e');
      setState(() {
        address_locality = "No address";
        address_country = "";
        current_latitude = 0;
        current_longitude = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      bottomNavigationBar: BottomNav.watch(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24),
          child: BlocProvider(
            create: (_) => EventCubit()..loadEventData(),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildSearch(),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Popular Event",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewAllPage(
                                      isPopularEvent: true,
                                    )),
                          );
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewAllPage(
                                      isPopularEvent: true,
                                      day: 1,
                                    )),
                          );
                        },
                        child: const Text(
                          "Day 1",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewAllPage(
                                      isPopularEvent: true,
                                      day: 2,
                                    )),
                          );
                        },
                        child: const Text(
                          "Day 2",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primaryColor),
                        ),
                      ),
                       GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewAllPage(
                                      isPopularEvent: true,
                                      day: 3,
                                    )),
                          );
                        },
                        child: const Text(
                          "Day 3",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primaryColor),
                        ),
                      ),
                       GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewAllPage(
                                      isPopularEvent: true,
                                      day: 4,
                                    )),
                          );
                        },
                        child: const Text(
                          "Day 4",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventError) {
                      return Center(child: Text(state.message));
                    } else if (state is EventLoaded) {
                      return _listPopularEvent(state.events);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(height: 12),
                Divider(
                  height: 1,
                  endIndent: 16,
                  indent: 16,
                  thickness: 0.5,
                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Event This Month",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewAllPage(
                                      isPopularEvent: false,
                                    )),
                          );
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventError) {
                      return Center(child: Text(state.message));
                    } else if (state is EventLoaded) {
                      return _listEventThisMonth(state.events);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Image.asset(
                      'assets/images/location.png',
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      address_country,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.greyTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    address_locality,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Navigate to the specific page here

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bc_st_pete.png'),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  _buildSearch() => Container(
        height: 48,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: AppColors.greyLightColor,
        ),
        child: Row(
          children: [
            Image.asset('assets/images/search.png', width: 16),
            const SizedBox(width: 8),
            const Text(
              "Search event...",
              style: TextStyle(
                  color: AppColors.greyTextColor, fontWeight: FontWeight.w500),
            )
          ],
        ),
      );

  _listPopularEvent(List<EventModel> events) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 270,
        child: Swiper(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          pagination: const SwiperPagination(
              builder: FractionPaginationBuilder(
                  fontSize: 20, activeFontSize: 20, color: Colors.grey),
              alignment: Alignment.bottomCenter),
          control: const SwiperControl(size: 0, padding: EdgeInsets.all(0)),
          itemCount: events.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.pushNamed(
              arguments: events[index].toJson(),
              context,
              NamedRoutes.detailScreen,
            ),
            child: CardPopularEvent(eventModel: events[index]),
          ),
        ),
      );

  _listEventThisMonth(List<EventModel> events) => Container(
        height: 640,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: events.length,
          reverse: true,
          itemBuilder: (context, index) => BlocBuilder<EventCubit, EventState>(
            builder: (context, state) {
              if (state is EventError) {
                return const Center(child: Text("Error"));
              } else if (state is EventLoaded) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      arguments: events[index].toJson(),
                      context,
                      NamedRoutes.detailScreen),
                  child: CardEventThisMonth(eventModel: events[index]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
}
