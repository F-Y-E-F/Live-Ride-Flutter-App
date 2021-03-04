import 'package:flutter/material.dart';

class TripDetailsScreen extends StatelessWidget {
  final int index;

  TripDetailsScreen(this.index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'map$index',
            child: InteractiveViewer(
              child: Image.network(
                'https://i.imgur.com/BDxieQD.png',
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Nice trip",
            style: theme.textTheme.headline4.copyWith(fontSize: 22),
          ),
          Container(
            width: 200,
            height: 3,
            color: Colors.red,
            margin: EdgeInsets.only(top: 5, bottom: 30),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1),
                        left: BorderSide(color: Colors.grey[300], width: 1),
                        top: BorderSide(color: Colors.grey[300], width: 1),
                        right:
                            BorderSide(color: Colors.grey[300], width: 0.5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TIME",
                      style: theme.textTheme.headline3,
                    ),
                    FittedBox(
                        child: Text(
                      "02:09:21",
                      style: theme.textTheme.headline4,
                    )),
                  ],
                ),
                height: 100,
              )),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey[300], width: 1),
                        left: BorderSide(color: Colors.grey[300], width: 0.5),
                        top: BorderSide(color: Colors.grey[300], width: 1),
                        right: BorderSide(color: Colors.grey[300], width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TIME",
                      style: theme.textTheme.headline3,
                    ),
                    FittedBox(
                        child: Text(
                      "02:09:21",
                      style: theme.textTheme.headline4,
                    )),
                  ],
                ),
                height: 100,
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1),
                            left: BorderSide(color: Colors.grey[300], width: 1),
                            top: BorderSide(color: Colors.grey[300], width: 1),
                            right:
                            BorderSide(color: Colors.grey[300], width: 0.5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TIME",
                          style: theme.textTheme.headline3,
                        ),
                        FittedBox(
                            child: Text(
                              "02:09:21",
                              style: theme.textTheme.headline4,
                            )),
                      ],
                    ),
                    height: 100,
                  )),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1),
                            left: BorderSide(color: Colors.grey[300], width: 0.5),
                            top: BorderSide(color: Colors.grey[300], width: 1),
                            right: BorderSide(color: Colors.grey[300], width: 1))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TIME",
                          style: theme.textTheme.headline3,
                        ),
                        FittedBox(
                            child: Text(
                              "02:09:21",
                              style: theme.textTheme.headline4,
                            )),
                      ],
                    ),
                    height: 100,
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1),
                            left: BorderSide(color: Colors.grey[300], width: 1),
                            top: BorderSide(color: Colors.grey[300], width: 1),
                            right:
                            BorderSide(color: Colors.grey[300], width: 0.5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TIME",
                          style: theme.textTheme.headline3,
                        ),
                        FittedBox(
                            child: Text(
                              "02:09:21",
                              style: theme.textTheme.headline4,
                            )),
                      ],
                    ),
                    height: 100,
                  )),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1),
                            left: BorderSide(color: Colors.grey[300], width: 0.5),
                            top: BorderSide(color: Colors.grey[300], width: 1),
                            right: BorderSide(color: Colors.grey[300], width: 1))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TIME",
                          style: theme.textTheme.headline3,
                        ),
                        FittedBox(
                            child: Text(
                              "02:09:21",
                              style: theme.textTheme.headline4,
                            )),
                      ],
                    ),
                    height: 100,
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1),
                            left: BorderSide(color: Colors.grey[300], width: 1),
                            top: BorderSide(color: Colors.grey[300], width: 1),
                            right:
                            BorderSide(color: Colors.grey[300], width: 0.5))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TIME",
                          style: theme.textTheme.headline3,
                        ),
                        FittedBox(
                            child: Text(
                              "02:09:21",
                              style: theme.textTheme.headline4,
                            )),
                      ],
                    ),
                    height: 100,
                  )),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1),
                            left: BorderSide(color: Colors.grey[300], width: 0.5),
                            top: BorderSide(color: Colors.grey[300], width: 1),
                            right: BorderSide(color: Colors.grey[300], width: 1))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TIME",
                          style: theme.textTheme.headline3,
                        ),
                        FittedBox(
                            child: Text(
                              "02:09:21",
                              style: theme.textTheme.headline4,
                            )),
                      ],
                    ),
                    height: 100,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
