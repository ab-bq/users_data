import 'package:flutter/material.dart';

networkError(BuildContext context, {VoidCallback? reload}) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/no-internet.png",
          width: 250,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text("Reload"),
          onPressed: reload,
        )
      ],
    ),
  );
}
