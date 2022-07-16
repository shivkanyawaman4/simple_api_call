import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/decoration.dart';
import '../widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

// CalendarController _controller;
class _MainPageState extends State<MainPage> {
  //list of students in school with all details

  List items = [
    {'title': 'Students', 'count': "100/150"},
    {'title': 'Staff', 'count': "10/35"},
    {'title': 'Total Fees', 'count': "45,000"},
    {'title': 'Total Paid', 'count': "35,000"},
    {'title': "Today's Collection", 'count': "10,000"},
    {'title': "Current Month", 'count': "150,000"},
  ];
  //list of students
   

  List child = [
    Container(
        child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: List.generate(4, (index) {
                          return Widgets.lisTile(
                              lText: '1',
                              title: 'Anil',
                              subtitle: 'Faculty',
                              onTap: () {});
                        }),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: decorationBorder1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Text(
                'VIEW ALL',
                style: midText,
              ),
            ),
          ),
        ),
        Widgets.buildButton(onTap: () {}, text: 'NOTICE'),
      ],
    )),
    Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(4, (index) {
                  return Widgets.lisTile(
                      lText: "Anil".toString()[0],
                      title: 'Anil',
                      subtitle: 'Faculty',
                      onTap: () {});
                }),
              ),
            ),
          ),
          Widgets.buildButton(onTap: () {}, text: 'LEAVE'),
        ],
      ),
    ),
  ];
  List staff = [];
  List students = [];
  List tempList = [];
  List countList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     
      
    FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'faculty')
        .get()
        .then((value) {
      Map data = value.docs[0].data();
      data['count'] = value.docs.length;
      data['title'] = 'Staff';

      countList.insert(0, data);
      for (int i = 0; i < value.docs.length; i++) {
        Map temp = value.docs[i].data();

        temp['facultyId'] = value.docs[i].id;
        temp['fName'] = value.docs[i]['fName'];
        temp['lName'] = value.docs[i]['lName'];
        temp['noticeTitle'] = 'Holiday Notice';
        temp['noticeDes'] = 'Holiday on 20th of March';
        temp['noticeUrl'] = 'https://www.google.com';
        temp['date'] = DateTime.now().toString();

        tempList.add(temp);
      }

      setState(() {
        staff = value.docs;
      });
    });

    FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'Student')
        .get()
        .then((value) {
      Map data = value.docs[0].data();
      data['count'] = value.docs.length;
      data['title'] = 'Students';
      countList.insert(1, data);

      setState(() {
        students = value.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    var isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;
    print(isPortrait);
    // print(countList.length);
    // print(countList.toString());
    // print(DateTime.now().toString());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            leading: const Icon(Icons.menu),
            title: const Text('Dashboard')),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      size.width < 800 ? size.width * 0.1 : size.width * 0.1,
                  vertical: size.height * 0.1),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                              ? size.width < 850
                                  ? size.width < 650
                                      ? size.width < 550
                                          ? size.width
                                          : size.width * 0.6
                                      : size.width * 0.4
                                  : size.width * 0.3
                              : size.width * 0.2,
                      mainAxisExtent: size.width < 1500
                          ? size.width < 1200
                              ? size.height * 0.24
                              : size.height * 0.24
                          : size.height * 0.22,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: size.width * 0.02,
                      mainAxisSpacing: size.height * 0.02,
                    ),
                    itemCount: items.length,
                    itemBuilder: (cntx, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.cyan, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    items[index]['title'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  items[index]['count'],
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                              ? size.width < 950
                                  ? size.width < 650
                                      ? size.width
                                      : size.width * 0.58
                                  : size.width * 0.4
                              : size.width * 0.34,
                      mainAxisExtent: size.width < 1500
                          ? size.width < 1200
                              ? isPortrait
                                  ? size.height * 1
                                  : size.height * 0.48
                              : size.height * 0.48
                          : size.height * 0.46,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: size.width * 0.02,
                      mainAxisSpacing: size.height * 0.02,
                    ),
                    itemCount: child.length + 1,
                    itemBuilder: (cntx, index) {
                      if (index == 2) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.grey,
                            border: Border.all(color: Colors.cyan, width: 1),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TableCalendar(
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: DateTime.now(),
                                    headerStyle: HeaderStyle(
                                      formatButtonDecoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius:
                                            BorderRadius.circular(22.0),
                                      ),
                                      formatButtonTextStyle: smallText,
                                      formatButtonShowsNext: false,
                                    ),
                                    startingDayOfWeek: StartingDayOfWeek.monday,
                                    // holidayPredicate: (DateTime date) {
                                    //   return date.day == 25 &&
                                    //       date.month == DateTime.now().month;
                                    // },
                                    // calendarStyle: CalendarStyle(
                                    //   outsideDaysVisible: false,
                                    //   weekendDecoration:  BoxDecoration(
                                    //     color: Colors.pink,
                                    //     borderRadius:
                                    //         BorderRadius.circular(10),
                                    //   ),

                                    // ),

                                    onDaySelected: (date, events) {
                                      print(date.toUtc());
                                    },
                                    calendarBuilders: CalendarBuilders(
                                      selectedBuilder:
                                          (context, date, events) => Container(
                                              margin: const EdgeInsets.all(5.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: Text(
                                                date.day.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              )),
                                      todayBuilder: (context, date, events) =>
                                          Container(
                                              margin: const EdgeInsets.all(5.0),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: Text(
                                                date.day.toString(),
                                                style: smallText,
                                              )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.grey,
                            border: Border.all(color: Colors.cyan, width: 1),
                          ),
                          child: child[index],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     print('pressed');
        //     //insert data first time create collection and then insert data
        //     // Map<String, dynamic> data = studentList.first;
        //     // data['id'] = id;
        //     // FirebaseFirestore.instance.collection('users').doc(id).set(data);

        //     //insert student data in database
        //     //  for (int i = 0; i < studentList.length; i++) {
        //     // String id =
        //     //     FirebaseFirestore.instance.collection('notice').doc().id;

        //     //   Map<String, dynamic> data = studentList[i];
        //     //   data['id'] = id;
        //     //   FirebaseFirestore.instance.collection('users').doc(id).set(data);
        //     // }

        //     //insert data first time create collection
        //     // Map<String, dynamic> data = tempList.first;
        //     // data['id'] = id;
        //     // FirebaseFirestore.instance.collection('notice').doc(id).set(data);

        //     // insert all list on clollection
        //     // for (int i = 0; i < tempList.length; i++) {
        //     //   String id =
        //     //       FirebaseFirestore.instance.collection('notice').doc().id;
        //     //   Map<String, dynamic> data = tempList[i];
        //     //   data['id'] = id;
        //     //   FirebaseFirestore.instance.collection('notice').doc(id).set(data);
        //     // }
        //   },
        //   child: const Icon(Icons.add),
        // ),
        );
  }
}
