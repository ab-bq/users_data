import 'package:flutter/material.dart';

import 'Utility.dart';
import 'common/UserAvatar.dart';
import 'model/User.dart';

class UserDetails extends StatelessWidget {
  final User user;
  final Color avatarBgColor;
  const UserDetails(this.user, this.avatarBgColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        systemOverlayStyle: Utility.getSystemUiOverlayStyle(context),
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: UserAvatar(
                  user.name,
                  avatarBgColor,
                  fontSize: 45,
                  radius: 45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  user.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "(@${user.username})",
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 20,
                thickness: 2,
                color: Color(0xFFF0E0D0),
              ),
              getContactDetails(context),
              getCompanyDetails(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  getContactDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4EDEB),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            title: Text(
              "Contact info",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: Text(user.phone),
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: Text(user.email),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Container(
                alignment: Alignment.center,
                width: double.minPositive,
                height: double.infinity,
                child: const Icon(Icons.home_outlined),
              ),
              title: Text("${user.address.street},\n${user.address.suite},\n${user.address.city}, ${user.address.zipcode}"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: Text(user.website),
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: Text("${user.address.geo.lat}, ${user.address.geo.lat}"),
          ),
        ],
      ),
    );
  }

  getCompanyDetails(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF4EDEB),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              title: Text(
                "Company info",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
            ListTile(
              title: Text("Name : ${user.company.name}"),
            ),
            ListTile(
              title: Text("Info : ${user.company.catchPhrase}"),
            ),
            ListTile(
              title: Text("Business : ${user.company.bs}"),
            ),
          ],
        ));
  }
}
