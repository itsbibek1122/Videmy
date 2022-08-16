import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/Videos/ProgrammingVhome_screen.dart';
import 'package:chat_app/Videos/ScienceVhome_screen.dart';
import 'package:chat_app/Screens/SplashScreen.dart';

import 'package:chat_app/Videos/EconomicsVhome_screen.dart';
import 'package:chat_app/Videos/HistoryVhome_screen.dart';
import 'package:chat_app/Videos/TechnologyVhome_screen.dart';
import 'package:flutter/material.dart';

class VideoMain extends StatefulWidget {
  @override
  State<VideoMain> createState() => _VideoMainState();
}

class _VideoMainState extends State<VideoMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Available Videos",
                style: TextStyle(
                  fontSize: 20.0,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CarouselSlider(
              items: [
                //1st Image of Slider
                GestureDetector(
                  onTap: () {
                    // Within the `FirstRoute` widget

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HistoryVhomeScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/history.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //2nd Image of Slider
                GestureDetector(
                  onTap: () {
                    // Within the `FirstRoute` widget

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProgrammingVhomeScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/programming.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //3rd Image of Slider
                // Container(
                //   margin: const EdgeInsets.all(6.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8.0),
                //     image: const DecorationImage(
                //       image: AssetImage('assets/images/marketing.jpg'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                //4th Image of Slider
                GestureDetector(
                  onTap: () {
                    // Within the `FirstRoute` widget

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TechnologyVhomeScreen()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/technology.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],

              //Slider Container properties
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
          ),

          //This is for the section below carousel

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Other Courses",
                style: TextStyle(
                  fontSize: 20.0,
                )),
          ),
          Column(
            children: [
              //This is below card
              Card(
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Expanded(
                            child: Image.asset("assets/images/economics.jpg"),
                            flex: 2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text("Economics"),
                                  subtitle: Text("GuruBaa"),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("PLAY"),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EconomicsVhomeScreen()),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Expanded(
                            child: Image.asset("assets/images/videmy.png"),
                            flex: 2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text("Chemistry"),
                                  subtitle: Text("Videmy Originals"),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("PLAY"),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                margin: const EdgeInsets.all(10),
              ),
              Card(
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Expanded(
                            child: Image.asset("assets/images/science.jpg"),
                            flex: 2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const Expanded(
                                flex: 5,
                                child: ListTile(
                                  title: Text("Science"),
                                  subtitle: Text("Science Channel"),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text("PLAY"),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScienceVhomeScreen()),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        flex: 8,
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                margin: const EdgeInsets.all(10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
