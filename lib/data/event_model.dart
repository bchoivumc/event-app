import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class EventModel {
  EventModel({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.eventType,
    required this.location,
    required this.description,
  });

  String id;
  String title;
  String image;
  String date;
  String startTime;
  String endTime;
  String eventType;
  String location;
  String description;

  static Future<String> getJson() {
    return rootBundle.loadString('assets/json/con_schedule.json');
  }

  factory EventModel.fromRawJson(String str) =>
      EventModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"]?? "",
        title: json["title"]?? "",
        image: json["image"]?? "https://img.freepik.com/free-photo/town-famous-attraction-landmark-village_1417-388.jpg?w=1060&t=st=1662380712~exp=1662381312~hmac=fd853eae11f31c295ee48bedc286ebc0534e289be71ae93c4f8d21d7003daa6e",
        date: json["date"]?? "",
        startTime: json["startTime"]?? "",
        endTime: json["endTime"]?? "",
        eventType: json["type"]?? "",
        location: json["location"]?? "",
        description: json["description"]?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "type": eventType,
        "location": location,
        "description": description,
      };
}
