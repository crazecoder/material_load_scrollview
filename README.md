# material_load_scrollview

A Flutter pull refresh and load more Plugin.

![Screenshot](https://raw.githubusercontent.com/crazecoder/material_load_scrollview/master/screenshots/view.gif)

## Getting Started

In your pubspec.yaml:

```yaml
dependencies:
  material_load_scrollview: ^1.0.0
```

```dart
import 'package:material_load_scrollview/material_load_scrollview.dart';
```

```dart
MaterialLoadScrollView(
          key: _key, //necessary for resetLoadStatus
          onRefresh: () {
          },
          onLoadMore: () {
          },
          child: ListView.builder(
            controller: ScrollController(),
            //necessary for scroll to top when onRefresh
            itemCount: _page * _itemCount,
            itemBuilder: (_, _i) => Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Text("$_i"),
                ),
          ),
        );
```

