import 'dart:convert';

import 'package:event_app/data/event_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  void loadEventData() async {
    emit(EventLoading());
    try {
      var jsonString = await EventModel.getJson();
      final rawJson = json.decode(jsonString);
      List<dynamic> jsonResult = rawJson['items'];
      // List<dynamic> jsonResult = json.decode(data);
      List<EventModel> events =
          jsonResult.map((e) => EventModel.fromJson(e)).toList();
      emit(EventLoaded(events: events));
    } catch (e) {
      emit(EventError(message: 'An error occurred while loading data'));
    }
  }
}
