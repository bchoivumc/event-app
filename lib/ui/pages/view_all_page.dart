import 'dart:convert';
import 'package:event_app/app/configs/colors.dart';
import 'package:event_app/app/resources/constant/named_routes.dart';
import 'package:event_app/data/event_model.dart';
import 'package:event_app/ui/widgets/card_event_this_month.dart';
import 'package:flutter/material.dart';

class ViewAllPage extends StatelessWidget {
  final bool isPopularEvent;
  final int? day;

  const ViewAllPage({super.key, required this.isPopularEvent, this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.wb_sunny),
          ),
        ],
        iconTheme: const IconThemeData(
          color: AppColors.blackColor,
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: FutureBuilder<List<EventModel>>(
        future: _loadEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            return EventList(
              events: snapshot.data!.toList(),
              isPopularEvent: isPopularEvent,
            );
          }
        },
      ),
    );
  }

  Future<List<EventModel>> _loadEvents() async {
    String jsonString = await EventModel.getJson();
    final rawJson = json.decode(jsonString);
    List<dynamic> jsonList = rawJson['items'];
    if (day != null) {
      switch (day) {
        case 1:
          return jsonList
              .map((json) => EventModel.fromJson(json))
              .toList()
              .where((element) => element.date == 'Sunday, September 8, 2024')
              .toList();
        case 2:
          return jsonList
              .map((json) => EventModel.fromJson(json))
              .toList()
              .where((element) => element.date == 'Monday, September 9, 2024')
              .toList();
        case 3:
          return jsonList
              .map((json) => EventModel.fromJson(json))
              .toList()
              .where((element) => element.date == 'Tuesday, September 10, 2024')
              .toList();
        case 4:
          return jsonList
              .map((json) => EventModel.fromJson(json))
              .toList()
              .where(
                  (element) => element.date == 'Wednesday, September 11, 2024')
              .toList();

        default:
      }
    }
    return jsonList.map((json) => EventModel.fromJson(json)).toList();
  }
}

class EventList extends StatelessWidget {
  final List<EventModel> events;
  final bool isPopularEvent;

  const EventList(
      {super.key, required this.events, required this.isPopularEvent});

  @override
  Widget build(BuildContext context) {
    List<EventModel> displayedEvents =
        isPopularEvent ? events : events.reversed.toList();

    return ListView.builder(
      itemCount: displayedEvents.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (() => Navigator.pushNamed(
              arguments: displayedEvents[index].toJson(),
              context,
              NamedRoutes.detailScreen)),
          child: CardEventThisMonth(
            eventModel: displayedEvents[index],
          ),
        );
      },
    );
  }
}
