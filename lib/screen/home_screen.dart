import 'dart:async';
import 'package:electroniccity/model/app_theme.dart';
import 'package:electroniccity/screen/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:electroniccity/drawer/homelist.dart';

class MyGuest extends StatefulWidget {
  const MyGuest({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyGuest> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  late Timer _timer;
  int _currentIndex = 0;
  List<String> imageUrls = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < imageUrls.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        setState(() {
          _currentIndex = 0;
        });
      }
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: isLightMode ? AppTheme.white01 : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                      child: SingleChildScrollView(
                          child: SizedBox(
                              width: width,
                              child: Column(
                                  children: [
                                    const SizedBox(
                          height: 10,
                        ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          children: [
                                            Padding(
                                    padding: const EdgeInsets.only(left: 4, ),
                                    child:
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.8,
                                      height: 40,
                                      child:
                                      TextField(
                                        decoration: InputDecoration(
                                          focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(Radius.circular(100))),
                                          enabledBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(Radius.circular(100))),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: isLightMode ? AppTheme.light : AppTheme.red,
                                          ),
                                          filled: true,
                                          fillColor: isLightMode ? AppTheme.light01 : AppTheme.white01,
                                          labelText: "Search jobs",
                                          labelStyle: TextStyle(
                                              color: isLightMode ? AppTheme.light : AppTheme.red),
                                        ),
                                      ),
                                    )),
                                            const Spacer(),
                                            const CircleAvatar(
                                  backgroundImage: AssetImage('assets/images/userprofile.jpeg'),
                                  radius: 20,
                                ),
                                          ],
                                        )
                                    ),
                                    Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: width,
                              child: const Card(
                                shadowColor: AppTheme.light,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text('Hey Naresh\nWhat did you think about the job?', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.light),),
                                ),
                              ),
                            )
                        ),
                                    SizedBox(
                                      height: height,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: Card(
                                          child: FutureBuilder<bool>(
                                            future: getData(),
                                            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                              if (!snapshot.hasData) {
                                                return const SizedBox();
                                              } else {
                                                return GridView(
                                                  padding: const EdgeInsets.only(left: 12, right: 12),
                                                  physics: const BouncingScrollPhysics(),
                                                  scrollDirection: Axis.vertical,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: multiple ? 3 : 1,
                                                    mainAxisSpacing: 5.0,
                                                    crossAxisSpacing: 4.0,
                                                    childAspectRatio: 1.1,
                                                  ),
                                                  children: List<Widget>.generate(
                                                    homeList.length, (int index) {
                                                      final int count = homeList.length;
                                                      final Animation<double> animation =
                                                      Tween<double>(begin: 0.0, end: 1.0).animate(
                                                        CurvedAnimation(
                                                          parent: animationController!,
                                                          curve: Interval((1 / count) * index, 1.0,
                                                              curve: Curves.fastOutSlowIn),
                                                        ),
                                                      );
                                                      animationController?.forward();
                                                      return HomeListView(
                                                        animation: animation,
                                                        animationController: animationController,
                                                        listData: homeList[index],
                                                        callBack: () {},
                                                      );
                                                      },
                                                  ),
                                                );
                                              }
                                              },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width,
                                      height: height*0.28,
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 10, top: 3),
                                          child: Row(
                                          children: [
                                            Container(
                                                height: 200,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    color: Colors.amber.withOpacity(0.1),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Card(
                                                  color: AppTheme.chipBackground,
                                                    elevation: 0,
                                                    child:  Padding(
                                                      padding: EdgeInsets.only(left: 10, top: 30),
                                                    child:
                                                    Text('Joined\nEmployees\nProfile with\nImages',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),)

                                                ),
                                                )
                                            ),
                                            Expanded(
                                              child: ListView(
                                            scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                                            children: items.map((item) {
                                              return
                                                SizedBox(
                                                width: width*0.4,
                                              // height: height*0.5,
                                              child:
                                                const Card(
                                                margin: EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Padding(padding: EdgeInsets.all(10),
                                                    child: CircleAvatar(
                                                      backgroundImage: AssetImage('assets/images/userprofile.jpeg'),
                                                      radius: 50,
                                                    ),
                                                    ),
                                                    Text('Virat K', style: TextStyle(fontWeight: FontWeight.bold),),
                                                Padding(padding: EdgeInsets.all(2),
                                                  child:
                                                    Text('Lorem Run texting without main function to make the way to...',),)

                                                  ],
                                                ),
                                              ));
                                            }).toList(),
                                          ),
                                            )
                                          ],
                                    ),
                        //     )

                    ),),
                                    ///BUTTON
                                    Card(
                    color: AppTheme.dark_grey,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Icon(Icons.close),)
                            ),
                            const Padding(
                                padding: EdgeInsets.only(top: 3, bottom: 3),
                                child: Icon(Icons.event_note_outlined)),
                            const Text('You have only 24 hours to apply for today\'s'),
                            const Text('job of the today'),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0)),
                                        backgroundColor: Colors.transparent,
                                    ),
                                    onPressed: () {

                                    },
                                    child: const Text('Didn\'t like Job',
                                      style: TextStyle(fontWeight: FontWeight.bold),)
                                ),
                                const Text(' '),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0)),
                                        backgroundColor: isLightMode ? AppTheme.light : AppTheme.red,
                                    ),
                                    onPressed: () {

                                    },
                                    child: const Text('View Job again',
                                      style: TextStyle(fontWeight: FontWeight.bold),)
                                )

                              ],
                            ))
                          ],
                        )
                    )
                  ), 
                                    const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Text('Apply to these jobs', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Spacer(),
                                            Text('View all'),
                                            Icon(Icons.navigate_next, color: AppTheme.light,),
                                            ],
                                          )),
                                    SizedBox(
                                        width: width,
                                        height: height*0.28,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10, top: 3),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: items.map((item) {
                                              return
                                                SizedBox(
                                                    width: width*0.9,
                                                    height: height*0.5,
                                                    child:
                                                    const Card(
                                                      margin: EdgeInsets.all(8.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                              padding: const EdgeInsets.all(10),
                                                              child: Row(
                                                                children: [
                                                                  Text('School Teacher', style: TextStyle(fontWeight: FontWeight.bold),),
                                                                  Spacer(), Icon(Icons.arrow_forward, color: AppTheme.light,)
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding: const EdgeInsets.only(left: 10),
                                                              child: Row(
                                                                children: [
                                                                  Text('\$19,400 -\$31,500',),
                                                                  Text('/Month', style: TextStyle(color: AppTheme.light),),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding: const EdgeInsets.only(left: 5, top: 2),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.house_outlined, color: AppTheme.light,),
                                                                  Text('S K Collection', style: TextStyle(color: AppTheme.light),),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding: const EdgeInsets.only(left: 5, top: 2),
                                                              child: Row(
                                                                children: [
                                                                  Icon(Icons.location_on_outlined, color: AppTheme.light,),
                                                                  Text('4th Phase JP Nagar, Bangalore', style: TextStyle(color: AppTheme.light),),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding: const EdgeInsets.only(left: 5, top: 2),
                                                              child: Row(
                                                                children: [
                                                                  Card(
                                                                    color: AppTheme.red01,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8),
                                                                      child: Text('New', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                                                                    )
                                                                  ),
                                                                  Card(
                                                                    borderOnForeground: true,
                                                                      shadowColor: AppTheme.light,
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8),
                                                                        child: Text('Vacancies', style: TextStyle(color: AppTheme.light)),
                                                                      )
                                                                  ),
                                                                ],
                                                              )),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                            child:
                                                            Divider(
                                                                height: 1,
                                                                indent: 10,
                                                                endIndent: 10,
                                                                color: Colors.black
                                                            ),),
                                                          Padding(
                                                              padding: const EdgeInsets.only(left: 5,),
                                                              child: Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Icon(Icons.verified, color: AppTheme.light,),
                                                                  Text('  Verified   Safe Hai Job ', style: TextStyle(color: AppTheme.light, fontWeight: FontWeight.bold),),
                                                                ],
                                                              )),

                                                        ],
                                                      ),
                                                    )
                                                );
                                            }).toList(),
                                          ),
                                        )
                                    ),
                                    Card(
                                      color: AppTheme.deactivatedText,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text('Jobs for all your needs', style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),
                                          SizedBox(
                                              width: width,
                                              height: height*0.35,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10, top: 3),
                                                child: ListView(
                                                  scrollDirection: Axis.horizontal,
                                                  children: items.map((item) {
                                                    return SizedBox(
                                                          width: width*0.4,
                                                          height: height*0.4,
                                                          child: Column(
                                                            children: [
                                                              const Card(
                                                                margin: EdgeInsets.all(8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets.all(10),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.location_on_outlined,),
                                                                            Spacer(),
                                                                          ],
                                                                        )),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 0, top: 10),
                                                                      child: Text('High Paying Jobs', style: TextStyle(fontWeight: FontWeight.bold),),

                                                                    ),
                                                                    Padding(
                                                                        padding: const EdgeInsets.only(left: 15, top: 8),
                                                                        child: Row(
                                                                          children: [
                                                                            Text('View 255 jobs', style: TextStyle(color: AppTheme.light),),
                                                                            Icon(Icons.navigate_next, color: AppTheme.light,),

                                                                          ],
                                                                        )),

                                                                  ],
                                                                ),
                                                              ),
                                                              const Card(
                                                                margin: EdgeInsets.all(8.0),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets.all(10),
                                                                        child: Row(
                                                                          children: [
                                                                            Icon(Icons.location_on_outlined,),
                                                                            Spacer(),
                                                                          ],
                                                                        )),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 0, top: 10),
                                                                      child: Text('High Paying Jobs', style: TextStyle(fontWeight: FontWeight.bold),),

                                                                    ),
                                                                    Padding(
                                                                        padding: const EdgeInsets.only(left: 15, top: 8),
                                                                        child: Row(
                                                                          children: [
                                                                            Text('View 255 jobs', style: TextStyle(color: AppTheme.light),),
                                                                            Icon(Icons.navigate_next, color: AppTheme.light,),

                                                                          ],
                                                                        )),

                                                                  ],
                                                                ),
                                                              )

                                                            ],
                                                          )
                                                      );
                                                  }).toList(),
                                                ),
                                              )
                                          ),

                                        ],
                                      ),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                  bottomBar()
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_outlined, color: AppTheme.light,),
                          Text(
                        'Electronic City',
                        style: TextStyle(
                          fontSize: 22,
                          color: isLightMode ? AppTheme.light : AppTheme.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ])
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.notifications_none,
                        color: isLightMode ? AppTheme.light : AppTheme.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
        this.listData,
        this.callBack,
        this.animationController,
        this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Card(
                          color: isLightMode ? AppTheme.white01 : AppTheme.white,
                          shadowColor: isLightMode ? AppTheme.nowhite : AppTheme.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(listData!.data, width: width * 0.1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  listData!.title,
                                  style: TextStyle(
                                    color: isLightMode ? AppTheme.light : AppTheme.red,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}