import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {

  final _airSubject = BehaviorSubject<AirResult>();
  Stream<AirResult> get airResult => _airSubject.stream;

  AirBloc() {
    print('AirBloc initalize');
    fetch();
  }

  Future<AirResult> fetchData() async {
    print("fetchData().....");
    var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=0607de95-cede-43b1-bf2f-8101f52cacfe');
    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  void fetch() async {
    print('fetch()');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

}