// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vertical_stepper_null_safety/vertical_stepper_null_safety.dart';
import 'package:vertical_stepper_null_safety/vertical_stepper_null_safety.dart'
    as step;

class ChatMessages {
  String messageContent;
  String messageType;
  ChatMessages({required this.messageContent, required this.messageType});
}

void main() => runApp(const MaterialApp(
      home: SafeArea(child: HomePage()),
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
  final dateTimeCurrent = DateTime.now();

  // google map\
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-28.4793, 24.6727);

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

  // messages list
  List<ChatMessages> messages = [
    ChatMessages(
        messageContent: "Welcome to Support:", messageType: "receiver"),
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
      body: pagesList(),
    );
  }

  Widget pagesList() {
    if (indexClicked == 0) {
      return ListView(
        children: [home()],
      );
    } else if (indexClicked == 1) {
      return liveTrack();
    } else if (indexClicked == 2) {
      return chatPage();
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 168, 168, 168),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(14),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Enter your tracking number",
                  ),
                ),
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
                  color: Colors.blue,
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
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
      ),
    );
  }

  Widget support() {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          "Welcome to Support",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.topLeft,
          width: 300,
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: ListTile(
            title: const Text(
              "Welcome to Delivado support service. How may we assist you today.",
            ),
            subtitle: Text.rich(
              TextSpan(
                  style: GoogleFonts.montserrat(),
                  text: "${dateTimeCurrent.hour}",
                  children: [
                    const TextSpan(
                      text: ":",
                    ),
                    TextSpan(
                      text: "${dateTimeCurrent.minute}",
                    ),
                  ]),
            ),
          ),
        )
      ],
    );
  }

  Widget chatPage() {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: messages.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment: (messages[index].messageType == "receiver"
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].messageType == "receiver"
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    messages[index].messageContent,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.blue,
                  elevation: 0,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
