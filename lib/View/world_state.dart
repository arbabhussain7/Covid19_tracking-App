import 'package:covid_app/Controllers/covid_controller.dart';
import 'package:covid_app/Model/world_states_modal.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:covid_app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

final WorldStatesController controller = Get.put(WorldStatesController());

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = [blueColor, greenColor, redColor];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: whiteColor,
                    size: 50,
                    controller: _controller,
                  ),
                );
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        "Total": double.parse(
                          controller.worldStates.value.cases.toString(),
                        ),
                        "Recovered": double.parse(
                          controller.worldStates.value.recovered.toString(),
                        ),
                        "Death": double.parse(
                          controller.worldStates.value.deaths.toString(),
                        ),
                      },
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      chartValuesOptions:
                          ChartValuesOptions(showChartValuesInPercentage: true),
                      legendOptions:
                          LegendOptions(legendPosition: LegendPosition.left),
                      animationDuration: const Duration(microseconds: 1200),
                      chartType: ChartType.ring,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * .06),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(
                                title: "Total",
                                value: controller.worldStates.value.cases
                                    .toString()),
                            ReusableRow(
                                title: "Recovered",
                                value: controller.worldStates.value.recovered
                                    .toString()),
                            ReusableRow(
                                title: "Deaths",
                                value: controller.worldStates.value.deaths
                                    .toString()),
                            ReusableRow(
                                title: "Today cases",
                                value: controller.worldStates.value.todayCases
                                    .toString()),
                            ReusableRow(
                                title: "Active",
                                value: controller.worldStates.value.active
                                    .toString()),
                            ReusableRow(
                                title: "Critical",
                                value: controller.worldStates.value.critical
                                    .toString()),
                            ReusableRow(
                                title: "Today Recovered",
                                value: controller
                                    .worldStates.value.todayRecovered
                                    .toString()),
                            ReusableRow(
                                title: "Today Death",
                                value: controller.worldStates.value.todayDeaths
                                    .toString()),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CountriesList());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text("Track Countries"),
                        ),
                      ),
                    )
                  ],
                );
              }
            })
          ],
        ),
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
