// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_n_go/core/constants/IP.dart';
import 'package:snap_n_go/domain/controllers/StockController.dart';

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
  final stockController = Get.put(StockController());
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
                      String imgSrc =
                          '$baseUrl/${widget.items[index]['imgUrl']}';
                      // print('item img-> $imgSrc');
                      return Dismissible(
                        key: Key(widget.items[index]['id'].toString()),
                        onDismissed: (direction) {
                          print('item id-> ${widget.items[index]['id']}');
                          var res = stockController
                              .removeStock(widget.items[index]['id']);
                          if (res == 1) {
                            Get.snackbar(
                                'Success', 'Warehouse successfully removed',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                borderRadius: 10,
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(10),
                                duration: Duration(seconds: 2),
                                icon: Icon(Icons.check, color: Colors.white));
                          } else
                            Get.snackbar('Error', 'Unable to remove warehouse',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                                margin: EdgeInsets.all(10),
                                borderRadius: 10,
                                icon: Icon(Icons.delete, color: Colors.white));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(widget.items[index]['name']),
                            subtitle: Text(widget.items[index]['address']),
                            leading: CircleAvatar(
                              child: widget.items[index]['imgUrl'] != null
                                  ? Image.network(
                                      imgSrc,
                                      fit: BoxFit.cover,
                                    )
                                  : Text('No Image Found.'),
                            ),
                            onTap: () async {
                              //sending stock ip to detail page to be able to fetch stock management related to it
                              await Get.toNamed('',
                                  arguments: [widget.items[index]['id']]);
                            },
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
