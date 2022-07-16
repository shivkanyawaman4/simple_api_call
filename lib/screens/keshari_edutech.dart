import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/decoration.dart';
import '../widgets.dart';

class KeshriEduTech extends StatefulWidget {
  const KeshriEduTech({Key? key}) : super(key: key);

  @override
  State<KeshriEduTech> createState() => _KeshriEduTechState();
}

class _KeshriEduTechState extends State<KeshriEduTech> {
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

  List tempList = [];
  List countList = [];
  int totalFees = 0;
  int paidFees = 0;
  int curMonth = 0;
  int oneDayColl = 0;
  bool showData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'faculty')
        .get()
        .then((value) {
      //get staff count
      Map data = {};
      data['count'] = "${value.docs.length}/10";
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
      for (int i = 0; i < value.docs.length; i++) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        DateFormat dateFormat1 = DateFormat("MM");

        var _date2 = dateFormat1.format(DateTime.now()).toString();
        var _date3 =
            dateFormat1.format(DateTime.parse(value.docs[i]["feesPaidOn"]));

        var _date = dateFormat.format(DateTime.now());
        var _date1 =
            dateFormat.format(DateTime.parse(value.docs[i]["feesPaidOn"]));
        //get total fees count
        totalFees += int.parse(
            value.docs[i]['totalFees'].toString().replaceFirst('Rs.', ''));

        //get paid fees count
        paidFees += int.parse(
            value.docs[i]['paidFees'].toString().replaceFirst('Rs.', ''));

        //get current month fees count
        if (_date1 == _date) {
          oneDayColl += int.parse(
              value.docs[i]['paidFees'].toString().replaceFirst('Rs.', ''));
        }

        //get current month fees count
        if (_date2 == _date3) {
          curMonth += int.parse(
              value.docs[i]['paidFees'].toString().replaceFirst('Rs.', ''));
        }
        setState(() {});
      }

      // for (int i = 0; i < value.docs.length; i++) {
      //   paidFees += int.parse(
      //       value.docs[i]['paidFees'].toString().replaceFirst('Rs.', ''));
      //   setState(() {});
      // }
      // for (int i = 0; i < value.docs.length; i++) {
      //   print('printing codnition//////////////');

      //   DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      //   var _date = dateFormat.format(DateTime.now());
      //   var _date1 =
      //       dateFormat.format(DateTime.parse(value.docs[i]["feesPaidOn"]));
      //   // print(_date);
      //   // print(_date1);

      //   if (_date1 == _date) {
      //     oneDayColl += int.parse(
      //         value.docs[i]['paidFees'].toString().replaceFirst('Rs.', ''));
      //     setState(() {});
      //   }
      //   // paidFees+= int.parse(value.docs[i]['paidFees'].toString().replaceFirst('Rs.', ''))  ;
      //   setState(() {});
      // }

      //get student count
      Map data = {};
      data['count'] = "${value.docs.length}/50";
      data['title'] = 'Students';
      countList.insert(1, data);

      Map tf = {};
      tf['count'] = totalFees;
      tf['title'] = 'Total Fees';
      countList.insert(2, tf);

      Map pf = {};
      pf['count'] = paidFees;
      pf['title'] = 'Paid Fees';
      countList.insert(3, pf);

      Map tc = {};
      tc['count'] = oneDayColl;
      tc['title'] = "Today's Collection";
      countList.insert(4, tc);

      Map cm = {};
      cm['count'] = curMonth;
      cm['title'] = "Current Month";
      countList.insert(5, cm);

      setState(() {
        showData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    var isPortrait =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          leading: const Icon(Icons.menu),
          title: const Text('Dashboard')),
      body: ListView(
        children: [
          Column(
            children: [
              showData
                  ? countList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width < 800
                                  ? size.width * 0.1
                                  : size.width * 0.1,
                              vertical: size.height * 0.1),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: ResponsiveWrapper.of(context)
                                    .isSmallerThan(DESKTOP)
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
                            mainAxisSpacing: size.height * 0.04,
                          ),
                          itemCount: countList.length,
                          itemBuilder: (cntx, index) {
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                    offset: const Offset(
                                        10, 10), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.cyan, width: 1),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          countList[index]['title'],
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
                                        countList[index]['count'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(
                          child: const Center(
                            child: Text('No Data Availble'),
                          ),
                        )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Colors.green,
                    )),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal:
                        size.width < 800 ? size.width * 0.1 : size.width * 0.1,
                    vertical: size.height * 0.1),
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
                  mainAxisSpacing: size.height * 0.04,
                ),
                itemCount: child.length + 1,
                itemBuilder: (cntx, index) {
                  if (index == 2) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(
                                10, 10), // changes position of shadow
                          ),
                        ],
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
                                    borderRadius: BorderRadius.circular(22.0),
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
                                  selectedBuilder: (context, date, events) =>
                                      Container(
                                          margin: const EdgeInsets.all(5.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
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
                                                  BorderRadius.circular(8.0)),
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
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(
                                10, 10), // changes position of shadow
                          ),
                        ],
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
