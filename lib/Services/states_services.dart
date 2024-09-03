import 'dart:convert';

import 'package:covid_app/Model/world_states_modal.dart';
import 'package:covid_app/Services/Utilities/app_url.dart';

import 'package:http/http.dart' as http;

// hit api here all and countries ........

class StatesServices {
  Future<WorldStatesModal> fetchWorkStateSRecords() async {
    final reponse = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (reponse.statusCode == 200) {
      var data = jsonDecode(reponse.body);
      return WorldStatesModal.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> CountriesListApi() async {
    var data;
    final reponse = await http.get(Uri.parse(AppUrl.countriesList));
    if (reponse.statusCode == 200) {
      var data = jsonDecode(reponse.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
