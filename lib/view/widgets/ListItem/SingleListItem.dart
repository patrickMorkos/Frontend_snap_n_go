import 'package:flutter/material.dart';
import 'package:snap_n_go/core/constants/Constants.dart';

class SingleListItem extends StatefulWidget {
  final String itemHeader;
  String itemTitle;
  final String itemSubTitle;
  final Function addBtnFunctionality;
  final Function removeBtnFunctionality;

  SingleListItem({
    Key? key,
    this.itemHeader = '',
    this.itemTitle = '',
    this.itemSubTitle = '',
    required this.addBtnFunctionality,
    required this.removeBtnFunctionality,
  }) : super(key: key);

  @override
  State<SingleListItem> createState() => _SingleListItemState();
}

class _SingleListItemState extends State<SingleListItem> {
  bool isDeleted = false;
  @override
  Widget build(BuildContext context) {
    return (isDeleted == true)
        ? Container()
        : Container(
            color: PRIMARY_COLOR,
            child: Column(
              children: <Widget>[
                Container(
                  height: 35.0,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(widget.itemHeader,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.itemTitle,
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            (widget.itemSubTitle).toString(),
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                // widget.itemSubTitle = widget.itemSubTitle - 1;
                                widget.itemTitle =
                                    widget.itemTitle.split(':')[0] +
                                        ': ' +
                                        (int.parse(widget.itemTitle
                                                    .split(':')[1]
                                                    .toString()) -
                                                1)
                                            .toString();
                              });
                              widget.removeBtnFunctionality();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.remove),
                              // Image(
                              //   image: AssetImage('assets/images/edit.png'),
                              //   width: 15,
                              //   height: 15,
                              // ),
                            ),
                          ),
                          //The delete Button
                          InkWell(
                            onTap: () {
                              setState(() {
                                // isDeleted = true;
                                // widget.itemSubTitle = widget.itemSubTitle + 1;
                                widget.itemTitle =
                                    widget.itemTitle.split(':')[0] +
                                        ': ' +
                                        (int.parse(widget.itemTitle
                                                    .split(':')[1]
                                                    .toString()) +
                                                1)
                                            .toString();
                              });
                              widget.addBtnFunctionality();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.add),
                              // Image(
                              //   image: AssetImage('assets/images/delete.png'),
                              //   width: 15,
                              //   height: 15,
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          );
  }
}
