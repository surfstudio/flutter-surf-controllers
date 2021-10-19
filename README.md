# Surf Controllers

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/surf_controllers)
[![Pub Version](https://img.shields.io/pub/v/surf_controllers?logo=dart&logoColor=white)](https://pub.dev/packages/surf_controllers)
[![Pub Likes](https://badgen.net/pub/likes/surf_controllers)](https://pub.dev/packages/surf_controllers)
[![Pub popularity](https://badgen.net/pub/popularity/surf_controllers)](https://pub.dev/packages/surf_controllers/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/surf_controllers)

This package made by [Surf](https://surf.ru).

## Description

Common controller for call dialogs.

## Installation

Add `surf_controllers` to your `pubspec.yaml` file:

```yaml
dependencies:
  surf_controllers: ^1.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

## Example

```dart
class DefaultDialogController implements DialogController {
  DefaultDialogController(
    this._scaffoldKey, {
    this.dialogOwner,
  });

  DefaultDialogController.from(
    this._context, {
    this.dialogOwner,
  });

  final DialogOwner? dialogOwner;

  BuildContext? _context;
  PersistentBottomSheetController? _sheetController;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  BuildContext? get context => _context ?? _scaffoldKey?.currentContext;

  ScaffoldState get _scaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context!);

  @override
  Future<R?> showAlertDialog<R>({
    String? title,
    String? message,
    ClickedAction? onAgreeClicked,
    ClickedAction? onDisagreeClicked,
    bool useRootNavigator = false,
  }) =>
      showDialog<R>(
        context: context!,
        useRootNavigator: useRootNavigator,
        builder: (ctx) => AlertDialog(
          title: title != null ? Text(title) : const SizedBox.shrink(),
          content: message != null ? Text(message) : const SizedBox.shrink(),
          actions: <Widget>[
            TextButton(
              onPressed: () => onDisagreeClicked?.call(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => onAgreeClicked?.call(ctx),
              child: const Text('Yes'),
            ),
          ],
        ),
      );

  @override
  Future<R?> showModalSheet<R>(
    Object type, {
    required DialogData data,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
  }) {
    assert(dialogOwner != null);
    assert(dialogOwner!.registeredDialogs.containsKey(type));

    final dialogBuilder = dialogOwner!.registeredDialogs[type]!;

    return showModalBottomSheet<R>(
      context: context!,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      builder: (ctx) => dialogBuilder(ctx, data: data),
    );
  }

  @override
  Future<R> showSheet<R>(
    Object type, {
    required DialogData data,
    VoidCallback? onDismiss,
  }) {
    assert(dialogOwner != null);
    assert(dialogOwner!.registeredDialogs.containsKey(type));

    final dialogBuilder = dialogOwner!.registeredDialogs[type]!;

    final sheetController = _scaffoldState.showBottomSheet<R>(
      (ctx) => dialogBuilder(ctx, data: data),
    );
    _sheetController = sheetController;

    return sheetController.closed.whenComplete(() {
      _sheetController = null;
      onDismiss?.call();
    });
  }

  void hideSheet() {
    _sheetController?.close();
  }
}
```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

For issues, file directly in the Issues section.

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
