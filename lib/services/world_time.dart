import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String flag;
  String url;
  late String time;
  late bool isDaytime;

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try {
      Response response = await get(Uri.https('worldtimeapi.org', '/api/timezone/$url', {'q': 'http'}));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 19;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }

  }
}