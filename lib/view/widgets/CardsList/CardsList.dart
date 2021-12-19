import 'dart:html';

import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key, required this.title, required this.items})
      : super(key: key);
  final String title;
  final List items;
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(children: [
          Text(widget.title, style: Theme.of(context).textTheme.headline6),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(widget.items[index]['name']),
                    subtitle: Text(widget.items[index]['address']),
                    leading: CircleAvatar(
                      child: widget.items[index]['imageUrl'] != null
                          ? Image.asset(widget.items[index]['imageUrl'])
                          : Text('No Image Found.'),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
