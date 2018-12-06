library material_load_scrollview;

import 'package:flutter/material.dart';

enum LoadingStatus { REFRESHING, LOADING, STABLE }

/// Signature for EndOfPageListeners
typedef void ListenerCallback();

/// A widget that wraps a [ScrollView] and will trigger [onEndOfPage] when it
/// reaches the bottom of the list
class MaterialLoadScrollView extends StatefulWidget {
  /// The [ScrollView] that this widget watches for changes on
  final ScrollView child;

  /// Called when the [child] reaches the end of the list
  final ListenerCallback onRefresh;
  final ListenerCallback onLoadMore;

  /// The offset to take into account when triggering [onEndOfPage] in pixels
  final int scrollOffset;
  final String loadingText;
  final Widget loadingWidget;

  @override
  State<StatefulWidget> createState() => MaterialLoadScrollViewState();

  MaterialLoadScrollView({
    Key key,
    @required this.child,
    @required this.onLoadMore,
    @required this.onRefresh,
    this.scrollOffset = 100,
    this.loadingText,
    this.loadingWidget,
  })  : assert(onRefresh != null),
        assert(onLoadMore != null),
        assert(child != null),
        super(key: key);
}

class MaterialLoadScrollViewState extends State<MaterialLoadScrollView>
    with TickerProviderStateMixin {
  LoadingStatus loadMoreStatus = LoadingStatus.STABLE;
  Column _column;

  @override
  void didUpdateWidget(MaterialLoadScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _column = Column(
      children: <Widget>[
        Expanded(
          child: NotificationListener(
            child: widget.child,
            onNotification: (notification) =>
                _onNotification(notification, context),
          ),
        ),
        loadMoreStatus == LoadingStatus.LOADING
            ? _buildLoadingView()
            : Container(
                height: 0,
              ),
      ],
    );
    return Scaffold(
      body: _column,
      floatingActionButton: FloatingActionButton(
          heroTag: "${DateTime.now()}",
          child: loadMoreStatus == LoadingStatus.REFRESHING
              ? RefreshProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Icon(Icons.refresh),
          mini: true,
          isExtended: true,
          onPressed: () {
            if (loadMoreStatus != null &&
                loadMoreStatus == LoadingStatus.STABLE) {
              setState(() {
                loadMoreStatus = LoadingStatus.REFRESHING;
              });
              widget.onRefresh();
            }
          }),
    );
  }

  Widget _buildLoadingView() =>
      widget.loadingWidget ??
      Container(
        height: 40,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(widget.loadingText ?? "loading..."),
              ),
            ],
          ),
        ),
      );

  bool _onNotification(Notification notification, BuildContext context) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.maxScrollExtent > notification.metrics.pixels &&
          notification.metrics.maxScrollExtent - notification.metrics.pixels <=
              widget.scrollOffset) {
        _loading();
      }
      return true;
    }
    if (notification is OverscrollNotification) {
      if (notification.overscroll > 0) {
        _loading();
      }
      return true;
    }
    return false;
  }

  _loading() {
    if (loadMoreStatus != null && loadMoreStatus == LoadingStatus.STABLE) {
      setState(() {
        loadMoreStatus = LoadingStatus.LOADING;
      });
      widget.onLoadMore();
    }
  }

  reset() {
    if (loadMoreStatus == LoadingStatus.REFRESHING)
      widget.child?.controller?.jumpTo(0);
    loadMoreStatus = LoadingStatus.STABLE;
  }
}
