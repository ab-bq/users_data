import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './model/User.dart';
import 'package:http/http.dart' as http;

import 'NetworkError.dart';
import 'UserDetails.dart';
import 'Utility.dart';
import 'common/UserAvatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> usersListFuture;

  @override
  void initState() {
    usersListFuture = fetchUserData();
    super.initState();
  }

  Future<List<User>> fetchUserData() async {
    String? jsonString;
    try {
      final http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        jsonString = response.body;
        Utility.saveUserDataInPreferences(jsonString);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    jsonString = jsonString ?? Utility.getUserDataFromSharedPreferences();
    if (jsonString != null) {
      var userList = json.decode(jsonString) as List;
      return userList.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch User Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users data",
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        systemOverlayStyle: Utility.getSystemUiOverlayStyle(context),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: usersListFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  User user = snapshot.data![index];
                  Color avatarBgColor = Color(COLORS[user.name.hashCode % COLORS.length]);
                  return ListTile(
                    leading: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      width: 40,
                      child: UserAvatar(user.name, avatarBgColor),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.phone),
                    onLongPress: () async {
                      await FlutterClipboard.copy(user.phone);
                      Utility.showToast("Phone copied to clipboard");
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetails(
                                    user,
                                    avatarBgColor,
                                  )));
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return networkError(context, reload: () {
                setState(() {
                  usersListFuture = fetchUserData();
                });
              });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
