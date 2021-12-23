import 'package:flutter/material.dart';
import 'package:snap_n_go/core/constants/Constants.dart';

class SingleListItem extends StatefulWidget {
  final String itemHeader;
  final String itemTitle;
  final String itemSubTitle;
  final Function deleteBtnFunctionality;
  final Function editBtnFunctionlity;

  SingleListItem({
    Key? key,
    this.itemHeader = '',
    this.itemTitle = '',
    this.itemSubTitle = '',
    required this.deleteBtnFunctionality,
    required this.editBtnFunctionlity,
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
                            widget.itemSubTitle,
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
                              widget.editBtnFunctionlity();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage('assets/images/edit.png'),
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                          //The delete Button
                          InkWell(
                            onTap: () {
                              setState(() {
                                isDeleted = true;
                              });
                              widget.deleteBtnFunctionality();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image(
                                image: AssetImage('assets/images/delete.png'),
                                width: 15,
                                height: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                )
              ],
            ),
          );
  }
}
