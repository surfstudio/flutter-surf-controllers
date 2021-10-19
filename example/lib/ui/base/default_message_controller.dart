import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

typedef SnackBarBuilder = SnackBar Function(String, SnackBarAction?);

class DefaultMessageController implements MessageController {
  final _defaultSnackBarBuilder = <MsgType, SnackBarBuilder>{
    MsgType.common: (text, action) => _defaultSnackBar(text, action: action),
    MsgType.error: (text, action) =>
        _defaultSnackBar(text, hasError: true, action: action),
  };

  BuildContext? _context;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  ScaffoldState get _scaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context!);

  DefaultMessageController(GlobalKey<ScaffoldState> scaffoldKey)
      : _scaffoldKey = scaffoldKey;

  DefaultMessageController.from(BuildContext context) : _context = context;

  @override
  void show({String? msg, Object? msgType}) {
    _show(type: msgType is MsgType ? msgType : MsgType.common, msg: msg ?? '');
  }

// ignore: avoid-returning-widgets
  static SnackBar _defaultSnackBar(
    String text, {
    bool hasError = false,
    SnackBarAction? action,
  }) {
    return SnackBar(
      content: Text(text),
      backgroundColor: hasError ? Colors.red : Colors.black,
      action: action,
    );
  }

  void _show({
    required MsgType type,
    required String msg,
    SnackBarAction? action,
  }) {
    final builder = _defaultSnackBarBuilder[type];
    if (builder != null) {
      _showBottomSnack(builder(msg, action));
    }
  }

  void _showBottomSnack(SnackBar snack) {
    _scaffoldState
      ..removeCurrentSnackBar() // ignore: deprecated_member_use
      ..showSnackBar(snack); // ignore: deprecated_member_use
  }
}

enum MsgType {
  common,
  error,
}
