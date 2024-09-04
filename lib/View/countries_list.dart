import 'package:covid_app/Controllers/covid_controller.dart';
import 'package:covid_app/Services/states_services.dart';
import 'package:covid_app/View/detail_screen.dart';
import 'package:covid_app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final WorldStatesController controller = Get.put(WorldStatesController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search name Countries",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: statesServices.CountriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 89,
                                        color: whiteColor,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: whiteColor,
                                      ),
                                      leading: Container(
                                        height: 10,
                                        width: 89,
                                        color: whiteColor,
                                      ),
                                    )
                                  ],
                                ),
                                baseColor: greyColor.withOpacity(0.7),
                                highlightColor: greyColor.withOpacity(0.1));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => DetailScreen(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          ));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]['country'],
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]['cases']
                                            .toString(),
                                      ),
                                      leading: Image(
                                          height: 60,
                                          width: 60,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => DetailScreen(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          ));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]['country'],
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]['cases']
                                            .toString(),
                                      ),
                                      leading: Image(
                                          height: 60,
                                          width: 60,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              Container();
                            }
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
