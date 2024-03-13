import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartrent_upahan/src/components/main_components/homepage_landlord.dart';

import '../../features/tenant_management/manage_tenants.dart';
import '../../utils/design/color_extension.dart';
import '../sub_components/add_subscription_view.dart';


class LandlordMainTabView extends StatefulWidget {
  const LandlordMainTabView({super.key});

  @override
  State<LandlordMainTabView> createState() => _LandlordMainTabViewState();
}

class _LandlordMainTabViewState extends State<LandlordMainTabView> {
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const LandlordHomePage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(children: [
        PageStorage(bucket: pageStorageBucket, child: currentTabView),
        SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/img/bottom_bar_bg.png"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 0;
                                  currentTabView = const LandlordHomePage();
                                });
                              },
                              icon: Image.asset(
                                "assets/img/home.png",
                                width: 20,
                                height: 20,
                                color: selectTab == 0
                                    ? TColor.white
                                    : TColor.gray30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 1;
                                  currentTabView = const TenantManagement(title: "Tenant Management");
                                });
                              },
                              icon: Image.asset(
                                "assets/img/budgets.png",
                                width: 20,
                                height: 20,
                                color: selectTab == 1
                                    ? TColor.white
                                    : TColor.gray30,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                              height: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 2;
                                  // currentTabView = CalendarView();
                                });
                              },
                              icon: Image.asset(
                                "assets/img/calendar.png",
                                width: 20,
                                height: 20,
                                color: selectTab == 2
                                    ? TColor.white
                                    : TColor.gray30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectTab = 3;
                                  // currentTabView = CardsView();
                                });
                              },
                              icon: Image.asset(
                                "assets/img/creditcards.png",
                                width: 20,
                                height: 20,
                                color: selectTab == 3
                                    ? TColor.white
                                    : TColor.gray30,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSubScriptionView()) );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: TColor.secondary.withOpacity(0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4))
                        ], borderRadius: BorderRadius.circular(50)),
                        child: Image.asset(
                          "assets/img/center_btn.png",
                          width: 55,
                          height: 55,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
