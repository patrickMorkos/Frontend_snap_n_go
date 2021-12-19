// ignore_for_file: non_constant_identifier_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snap_n_go/core/utils/Common.dart';
import 'package:snap_n_go/data/apiService.dart';
import 'package:snap_n_go/domain/controllers/LoginController.dart';
import 'package:snap_n_go/domain/controllers/StockController.dart';
import 'package:snap_n_go/domain/models/Stock.dart';
import 'package:snap_n_go/view/widgets/AppBar/Appbar.dart';
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
  List<dynamic> stocks = [];
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
    _fetchStocks();
  }

  void _fetchStocks() async {
    await stockController.getStocksByUserId(loginController.userInfo['id']);
    setState(() {
      stocks = stockController.stocks != null ? stockController.stocks : [];
    });
    print('stockssss $stocks');
  }

  //This Function of type widget returns the whole body of the ManageStock
  Widget _ManageStockBody(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Container containing text and image
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: getSw(context) / 21, right: getSw(context) / 21),
              // color: Colors.red,
              width: getSw(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back !',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: getSh(context) / 50,
                  ),
                  CustomButton(
                    title: 'Add Warehouse',
                    onTapCallBack: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            enabled: true,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              nameController.text = value;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            enabled: true,
                                            decoration: InputDecoration(
                                              labelText: 'Address',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              nameController.text = value;
                                            },
                                          ),
                                        ),
                                        ConstrainedBox(
                                          constraints:
                                              const BoxConstraints.tightFor(
                                                  width: 100.0),
                                          child: _pickingType == FileType.custom
                                              ? TextFormField(
                                                  maxLength: 15,
                                                  autovalidateMode:
                                                      AutovalidateMode.always,
                                                  controller:
                                                      extensionController,
                                                  decoration: InputDecoration(
                                                    labelText: 'File extension',
                                                  ),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                )
                                              : const SizedBox(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 50.0, bottom: 20.0),
                                          child: Column(
                                            children: <Widget>[
                                              ElevatedButton(
                                                onPressed: () => _pickFiles(),
                                                child: Text(_multiPick
                                                    ? 'Pick files'
                                                    : 'Pick file'),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        Builder(
                                          builder: (BuildContext context) =>
                                              _isLoading
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10.0),
                                                      child:
                                                          const CircularProgressIndicator(),
                                                    )
                                                  : _userAborted
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 10.0),
                                                          child: const Text(
                                                            'User has aborted the dialog',
                                                          ),
                                                        )
                                                      : _directoryPath != null
                                                          ? ListTile(
                                                              title: const Text(
                                                                  'Directory path'),
                                                              subtitle: Text(
                                                                  _directoryPath!),
                                                            )
                                                          : _paths != null
                                                              ? Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          30.0),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.50,
                                                                  child:
                                                                      Scrollbar(
                                                                          child:
                                                                              ListView.separated(
                                                                    itemCount: _paths !=
                                                                                null &&
                                                                            _paths!
                                                                                .isNotEmpty
                                                                        ? _paths!
                                                                            .length
                                                                        : 1,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      final bool
                                                                          isMultiPath =
                                                                          _paths != null &&
                                                                              _paths!.isNotEmpty;
                                                                      final String
                                                                          name =
                                                                          'File $index: ' +
                                                                              (isMultiPath ? _paths!.map((e) => e.name).toList()[index] : _fileName ?? '...');
                                                                      final path = isWebDevice()
                                                                          ? null
                                                                          : _paths!
                                                                              .map((e) => e.path)
                                                                              .toList()[index]
                                                                              .toString();

                                                                      return ListTile(
                                                                        title:
                                                                            Text(
                                                                          name,
                                                                        ),
                                                                        subtitle:
                                                                            Text(path ??
                                                                                ''),
                                                                      );
                                                                    },
                                                                    separatorBuilder:
                                                                        (BuildContext context,
                                                                                int index) =>
                                                                            const Divider(),
                                                                  )),
                                                                )
                                                              : _saveAsFileName !=
                                                                      null
                                                                  ? ListTile(
                                                                      title: const Text(
                                                                          'Save file'),
                                                                      subtitle:
                                                                          Text(
                                                                              _saveAsFileName!),
                                                                    )
                                                                  : const SizedBox(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomButton(
                                            title: "Submit",
                                            onTapCallBack: () async{
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState!.save();
                                                var stock= Stock(name: nameController.text.toString(), address: addressController.text.toString(), products: [], stockProducts: []);
                                                var res=await stockController.addStock(stock);
                                                customAlert(context, 'Success', res, AlertType.success, Colors.orange);
                                              } else {
                                                customAlert(context, 'Error', 'Please fill all the fields', AlertType.error, Colors.red);
                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                      // showGeneralDialog(
                      //     barrierColor: Colors.black.withOpacity(0.5),
                      //     transitionBuilder: (context, a1, a2, child) {
                      //       return Transform.scale(
                      //         scale: a1.value,
                      //         child: Opacity(
                      //           opacity: a1.value,
                      //           child: AlertDialog(
                      //             insetPadding: EdgeInsets.zero,
                      //             shape: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.circular(16.0)),
                      //             actions: <Widget>[
                      //               Expanded(
                      //                 child: SingleChildScrollView(
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.spaceEvenly,
                      //                     children: [
                      //                       Expanded(
                      //                         child: Container(
                      //                           child: TextFormField(
                      //                             controller: nameController,
                      //                             enabled: true,
                      //                             showCursor: true,
                      //                             textInputAction:
                      //                                 TextInputAction.done,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Expanded(
                      //                           child: Container(
                      //                         child: TextFormField(
                      //                           controller: addressController,
                      //                           enabled: true,
                      //                           showCursor: true,
                      //                           textInputAction:
                      //                               TextInputAction.done,
                      //                         ),
                      //                       )),
                      //                       CustomButton(
                      //                         title: 'Submit',
                      //                         onTapCallBack: () {
                      //                           var newStock = Stock(
                      //                               name: nameController.text
                      //                                   .toString(),
                      //                               address: addressController
                      //                                   .text
                      //                                   .toString(),
                      //                               products: [],
                      //                               stockProducts: []);
                      //                           stockController
                      //                               .addStock(newStock);
                      //                           customAlert(
                      //                               context,
                      //                               'Success',
                      //                               'Warehouse Successfully Created',
                      //                               AlertType.success,
                      //                               Colors.orange[300]);
                      //                         },
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     transitionDuration: Duration(milliseconds: 400),
                      //     barrierDismissible: true,
                      //     barrierLabel: '',
                      //     context: context,
                      //     pageBuilder: (context, animation, secondaryAnimation) {
                      //       return                                     Expanded(
                      //                 child: SingleChildScrollView(
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.spaceEvenly,
                      //                     children: [
                      //                       Expanded(
                      //                         child: Container(
                      //                           child: TextFormField(
                      //                             controller: nameController,
                      //                             enabled: true,
                      //                             showCursor: true,
                      //                             textInputAction:
                      //                                 TextInputAction.done,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Expanded(
                      //                           child: Container(
                      //                         child: TextFormField(
                      //                           controller: addressController,
                      //                           enabled: true,
                      //                           showCursor: true,
                      //                           textInputAction:
                      //                               TextInputAction.done,
                      //                         ),
                      //                       )),
                      //                       CustomButton(
                      //                         title: 'Submit',
                      //                         onTapCallBack: () {
                      //                           var newStock = Stock(
                      //                               name: nameController.text
                      //                                   .toString(),
                      //                               address: addressController
                      //                                   .text
                      //                                   .toString(),
                      //                               products: [],
                      //                               stockProducts: []);
                      //                           stockController
                      //                               .addStock(newStock);
                      //                           customAlert(
                      //                               context,
                      //                               'Success',
                      //                               'Warehouse Successfully Created',
                      //                               AlertType.success,
                      //                               Colors.orange[300]);
                      //                         },
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //     });
                    },
                  ),
                  SizedBox(
                    height: getSh(context) / 50,
                  ),
                  CardList(title: 'Available Warehouses', items: stocks)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///This is the build function of the MenuItem() widget class
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Container(
          height: screenSize.height * 0.8,
          width: screenSize.width,
          child: Column(
            children: [CustomAppBar(), _ManageStockBody(context)],
          ),
        ));
  }
}
