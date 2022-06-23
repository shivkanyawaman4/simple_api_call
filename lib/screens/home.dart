import 'package:flutter/material.dart';

import '../api/api.dart';
import '../constants/colors.dart';
import '../modals/testing_modal.dart';
import 'detais.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Data> _posts = [];
  bool showData = false;
  @override
  void initState() {
    super.initState();
    ApiServices.getPosts().then((value) {
      if (value.isNotEmpty) {
        value['data'].forEach((element) {
          _posts.add(Data.fromJson(element));
          showData = true;
          setState(() {});
        });
      } else {
        showData = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Home'),
      ),
      body: showData
          ? _posts.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Details()));
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(_posts[index].firstName!),
                              subtitle: Text(_posts[index].lastName!),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(_posts[index].avatar!),
                              ),
                            ),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                  itemCount: _posts.length)
              : const Text('No Data')
          : Center(
              child: CircularProgressIndicator(
                color: appBarColor,
              ),
            ),
    );
  }
}
