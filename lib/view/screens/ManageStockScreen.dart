// ignore_for_file: non_constant_identifier_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/controllers/LoginController.dart';
import 'package:snap_n_go/domain/controllers/StockController.dart';
import 'package:snap_n_go/domain/models/Stock.dart';
import 'package:snap_n_go/view/widgets/CardsList/CardsList.dart';
import 'package:snap_n_go/view/widgets/CustomButton/CustomButton.dart';
import 'package:snap_n_go/view/widgets/Menu/Menu.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

///This widget class is responsible of the ManageStock() content
///It has a menu and the body of the ManageStock()

class ManageStock extends StatefulWidget {
  @override
  State<ManageStock> createState() => _ManageStock();
}

class _ManageStock extends State<ManageStock> {
  //This variable is responsible of the Stock screen active button from the menu
  int whichBtn = 2;
  List<dynamic> stocksData = [];
  final stockController = Get.put(StockController());
  final loginController = Get.put(LoginController());
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final extensionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _selectFolder() async {
    _resetState();
    try {
      String? path = await FilePicker.platform.getDirectoryPath();
      setState(() {
        _directoryPath = path;
        _userAborted = path == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveFile() async {
    _resetState();
    try {
      String? fileName = await FilePicker.platform.saveFile(
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        type: _pickingType,
      );
      setState(() {
        _saveAsFileName = fileName;
        _userAborted = fileName == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
    print('filename: $_fileName');
  }

  @override
  void initState() {
    super.initState();
    //Getting the list of stocks from the backend using the genericGet function
    Future.delayed(Duration.zero, () async {
      dynamic list = await genericGet("Stock", "user/1");
      setState(() {
        stocksData = list;
      });
      print("THE STOCKS ARE=========>" + list.toString());
    });
  }

  // void _fetchStocks() async {
  //   await stockController.getStocksByUserId(loginController.userInfo['id']);
  //   setState(() {
  //     stocks = stockController.stocks;
  //   });
  //   print('stockssss $stocks');
  // }

  //This Function of type widget returns the whole body of the ManageStock
  Widget _ManageStockBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: getSw(context) / 21,
                  right: getSw(context) / 21,
                ),
                width: getSw(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Header
                    Center(
                      child: Text(
                        'Your stocks',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //Devider
                    Divider(
                      indent: getSw(context) / 100,
                      endIndent: getSw(context) / 100,
                    ),
                    SizedBox(
                      height: getSh(context) / 50,
                    ),
                    //Stocks list
                    Container(
                      height: getSh(context) / 1.7,
                      child: CardList(
                        title: 'Available Warehouses',
                        items: stocksData,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///This is the build function of the ManageStockScreen() widget class
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Container(
          width: screenSize.width,
          child: Column(
            children: [
              Menu(
                isActive: whichBtn,
              ),
              _ManageStockBody(context)
            ],
          ),
        ));
  }
}
