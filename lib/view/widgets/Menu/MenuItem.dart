import 'package:flutter/material.dart';
import 'package:snap_n_go/core/constants/Constants.dart';
import 'package:snap_n_go/core/utils/Common.dart';

///This widget class is responsible of the a single item from the menu
///It contains a text and a (container) if the item is active
///and a (SizedBox) if the item is not active

class MenuItem extends StatefulWidget {
  final String title;
  bool isActive;
  final Function? onTapCallBack;

  ///Those are the parameters of the MenuItem() widget class
  ///The parameter [title] is a String variable and
  ///it is responsible of the text to be displayed in the item
  ///The parameter [isActive] ia a bool variable and
  /// it is responsible of the state of the menu item if it is clicked or not
  /// The parameter [onTapCallBack] is a Function variable and
  /// it is responsible of the action to be performed when the item is clicked

  MenuItem({
    Key? key,
    required this.title,
    this.isActive = false,
    this.onTapCallBack,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getSw(context) / 21),
      child: InkWell(
        onTap: () {
          widget.onTapCallBack!();
          //Changing the state of the item when it is clicked to active
          setState(() {
            widget.isActive = true;
          });
        },
        child: MouseRegion(
          child: Column(
            children: [
              Text(
                '${widget.title}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.isActive ? PRIMARY_COLOR : Colors.deepOrange),
              ),
              SizedBox(
                height: getSh(context) / 131.5,
              ),
              widget.isActive
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getSw(context) / 133,
                          vertical: getSh(context) / 394.5),
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
