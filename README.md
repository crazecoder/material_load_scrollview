# material_load_scrollview
[![pub package](https://img.shields.io/pub/v/material_load_scrollview.svg)](https://pub.dartlang.org/packages/material_load_scrollview)

A widget that make the ScrollView to be push to load data,and click to refresh data,support custom footer,Theoretically compatible with all Scrollable Widgets.

![Screenshot](https://raw.githubusercontent.com/crazecoder/material_load_scrollview/07e54df4d9c2cf07bdfbb50ffc9cad404ca352dd/screenshots/view.gif)

## Getting Started

In your pubspec.yaml:

```yaml
dependencies:
  material_load_scrollview: lastVersion
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
            controller: ScrollController(), //necessary for scroll to top when onRefresh
            itemCount: _page * _itemCount,
            itemBuilder: (_, _i) => Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Text("$_i"),
                ),
          ),
        );

_key.currentState.reset();
```
# Thanks
[QuirijnGB / lazy-load-scrollview](https://github.com/QuirijnGB/lazy-load-scrollview)
