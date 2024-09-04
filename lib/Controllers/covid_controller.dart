import 'package:covid_app/Model/world_states_modal.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WorldStatesController extends GetxController {
  final StatesServices statesServices =
      StatesServices(); // Create an instance of the service
  var worldStates = WorldStatesModal().obs;
  TextEditingController searchController =
      TextEditingController(); // Observable to hold the data
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWorldStates();
  }

  void fetchWorldStates() async {
    try {
      isLoading(true);
      var states = await statesServices.fetchWorkStateSRecords();
      if (states != null) {
        worldStates.value = states;
      }
    } finally {
      isLoading(false);
    }
  }
}
