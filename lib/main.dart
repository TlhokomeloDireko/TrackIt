// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  // google map\
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //create list of data for stepper!!
  List<step.Step> steps = [
    step.Step(
      shimmer: false,
      title: "Order Placed",
      iconStyle: Colors.green,
      content: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "2022/10/20 11:25 AM Order Created !!",
            style: GoogleFonts.montserrat(),
          ),
        ),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Dispatch in Progress",
      iconStyle: Colors.green,
      content: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "2022/10/20 04:20 PM Parcel Read To Dispatch !!",
            style: GoogleFonts.montserrat(),
          ),
        ),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Ready For Pickup",
      iconStyle: Colors.green,
      content: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "2022/10/21 10:30 AM Parcel Sorted !!",
            style: GoogleFonts.montserrat(),
          ),
        ),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "In Transit",
      iconStyle: Colors.green,
      content: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "2022/10/21 04:10 PM Parcel Arrived At Delivery Hub !!",
            style: GoogleFonts.montserrat(),
          ),
        ),
      ),
    ),
    step.Step(
      shimmer: false,
      title: "Out For Delivery",
      iconStyle: Colors.blue,
      content: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("See Live Tracking", style: GoogleFonts.montserrat()),
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
            label: "Package Info",
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
      return support();
    } else {
      return const Icon(Icons.error);
    }
  }

  Widget home() {
    return Column(
      children: [
        Container(
          height: 200,
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
                    width: 150,
                    image: AssetImage("assets/logo.png"),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "Deli",
                        style: GoogleFonts.montserrat(
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue),
                        children: [
                          TextSpan(
                            text: "vado",
                            style: GoogleFonts.montserrat(
                                color: Colors.red,
                                fontSize: 35,
                                fontWeight: FontWeight.w800),
                          )
                        ]),
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
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: ListTile(
            title: Text(
              "Tracking Number :",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 240,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 168, 168, 168),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Enter your tracking number",
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
    return SizedBox(
      height: 900,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }

  Widget support() {
    return Column(
      children: const [],
    );
  }
}
