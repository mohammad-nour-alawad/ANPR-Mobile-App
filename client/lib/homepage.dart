import 'package:client/pages/list_screen.dart';
import 'package:client/pages/logout_screen.dart';
import 'package:flutter/material.dart';
import 'package:client/VideoStreaming.dart';

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: const Size(88, 44),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  backgroundColor: Colors.blue,
);

class HomePage extends StatefulWidget {
  const HomePage({Key? key /*, required this.isLoggedIn*/}) : super(key: key);
  final bool isLoggedIn = false;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String currentPage = "1";

  var index = 0;
  var pageKeys = ["1", "2", "3"];

  Map<String, GlobalKey<NavigatorState>> navKeys = {
    "1": GlobalKey<NavigatorState>(),
    "2": GlobalKey<NavigatorState>(),
    "3": GlobalKey<NavigatorState>(),
  };

  double screenHeight = 0, screenWidth = 0;
  double topPadding = 0, bottomPadding = 0;

  late TabController tabController;

  final contentViews = [
    DetectionListScreen(),
    const VideoStream(),
    const LogoutScreen(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.01;
    return Scaffold(
      backgroundColor: const Color(0xff1e1e24),
      //endDrawer: drawer(),
      key: scaffoldKey,
      body: LayoutBuilder(
        builder: ((context, constraints) {
          if (constraints.maxWidth < 0) {
            return desktopView();
          } else {
            return mobileView();
          }
        }),
      ),
    );
  }

  Widget mobileView() {
    return Scaffold(
      body: contentViews[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.orange.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 80,
          backgroundColor: const Color.fromARGB(255, 255, 188, 89),
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
              currentPage = pageKeys[index];
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.email_outlined),
              selectedIcon: Icon(Icons.email),
              label: "Detections",
            ),
            NavigationDestination(
              icon: Icon(Icons.videocam_outlined),
              selectedIcon: Icon(Icons.videocam),
              label: "Live Stream",
            ),
            NavigationDestination(
              icon: Icon(Icons.logout),
              selectedIcon: Icon(Icons.logout),
              label: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Widget desktopView() {
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.05, right: 0.05 * screenHeight),
      child: Container(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              iconSize: screenWidth * 0.08,
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              icon: const Icon(Icons.menu_rounded),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

/*
  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
              Container(
                height: screenHeight * 0.1,
              )
            ] +
            contentViews
                .map(
                  (e) => Container(
                    child: ListTile(
                      title: Text(e.tab.title),
                      onTap: () {},
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
  */
}

/*
Widget StreamView() {
  String url = "https://www.youtube.com/watch?v=W-rHIsDFrzQ";

  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(url) as String,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      isLive: false,
      enableCaption: false,
    ),
  );

  return Scaffold(
    appBar: AppBar(
      title: const Text("ALPR Dashboard: Live Stream"),
    ),
    body: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: controller),
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              player,
              const SizedBox(
                height: 40,
              ),
              const Text("YOUTUBE Video !!!")
            ],
          );
        }),
  );
}
*/