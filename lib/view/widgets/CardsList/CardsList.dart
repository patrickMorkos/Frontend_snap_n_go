import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(widget.title, style: Theme.of(context).textTheme.headline6),
          Container(
            child: widget.items.length > 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      // print('itemm-> ${widget.items[index]}');
                      return InkWell(
                        onTap: () {
                          print(
                              'THIS STOCK IS' + widget.items[index].toString());
                          Get.toNamed("/Products",
                              arguments: widget.items[index]);
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(widget.items[index]['name']),
                            subtitle: Text(widget.items[index]['address']),
                            leading: CircleAvatar(
                              child: widget.items[index]['imageUrl'] != null
                                  ? Image.asset(widget.items[index]['imageUrl'])
                                  : Text('No Image Found.'),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: Text('No items')),
          ),
        ]),
      ),
    );
  }
}
