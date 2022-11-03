// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vertical_stepper_null_safety/vertical_stepper_null_safety.dart';
import 'package:vertical_stepper_null_safety/vertical_stepper_null_safety.dart'
    as step;

void main() => runApp(const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool result = false;
  int indexClicked = 0;

  // create a list of pages
  final pages = [];

  //create list of data for stepper!!
  List<step.Step> steps = [
    const step.Step(
      shimmer: false,
      title: "Order Placed",
      iconStyle: Colors.green,
      content: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("2022/10/20 11:25 AM Order Created !!"),
        ),
      ),
    ),
    const step.Step(
      shimmer: false,
      title: "Dispatch in Progress",
      iconStyle: Colors.green,
      content: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("2022/10/20 04:20 PM Parcel Read To Dispatch !!"),
        ),
      ),
    ),
    const step.Step(
      shimmer: false,
      title: "Ready For Pickup",
      iconStyle: Colors.green,
      content: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("2022/10/21 10:30 AM Parcel Sorted !!"),
        ),
      ),
    ),
    const step.Step(
      shimmer: false,
      title: "In Transit",
      iconStyle: Colors.green,
      content: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("2022/10/21 04:10 PM Parcel Arrived At Delivery Hub !!"),
        ),
      ),
    ),
    const step.Step(
      shimmer: false,
      title: "Out For Delivery",
      iconStyle: Colors.blue,
      content: Padding(
        padding: EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(""),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        currentIndex: indexClicked,
        onTap: (value) {
          setState(() {
            indexClicked = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.track_changes,
            ),
            label: "Live Track",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.support_agent_outlined,
            ),
            label: "Support",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: ListView(
        children: [
          pagesList(),
        ],
      ),
    );
  }

  Widget pagesList() {
    if (indexClicked == 0) {
      return home();
    } else if (indexClicked == 1) {
      return liveTrack();
    } else if (indexClicked == 2) {
      return liveTrack();
    } else if (indexClicked == 3) {
      return liveTrack();
    } else {
      return const Icon(Icons.error);
    }
  }

  Widget home() {
    return Column(
      children: [
        Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("assets/images.jpeg"),
                  ),
                  Text(
                    "Parcel Tracker",
                    style: GoogleFonts.montserrat(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
        homeBody(),
      ],
    );
  }

  Widget homeBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Text(
            "Tracking Number :",
            style: GoogleFonts.montserrat(fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "e.g #12515489665544",
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    result = true;
                  });
                },
                child: const Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        result
            ? Padding(
                padding: const EdgeInsets.fromLTRB(35, 2, 31, 0),
                child: Row(
                  children: [
                    Text(
                      "Results : ",
                      style: GoogleFonts.montserrat(fontSize: 25),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          result = false;
                        });
                      },
                      child: const Icon(Icons.close, size: 25),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 5,
        ),
        result
            ? Padding(
                padding: const EdgeInsets.fromLTRB(15, 2, 15, 0),
                child: VerticalStepper(
                  steps: steps,
                  dashLength: 2,
                ),
              )
            : Transform(
                transform: Matrix4.translationValues(0, -50, 0),
                child: Lottie.network(
                    "https://assets2.lottiefiles.com/packages/lf20_t24tpvcu.json")),
      ],
    );
  }

  Widget liveTrack() {
    return Column(
      children: const [],
    );
  }
}
