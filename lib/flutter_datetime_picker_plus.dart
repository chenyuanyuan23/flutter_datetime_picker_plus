import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/src/date_model.dart';
import 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart'
    as picker_theme;
import 'package:flutter_datetime_picker_plus/src/i18n_model.dart';

export 'package:flutter_datetime_picker_plus/src/date_model.dart';
export 'package:flutter_datetime_picker_plus/src/datetime_picker_theme.dart';
export 'package:flutter_datetime_picker_plus/src/i18n_model.dart';

typedef DateChangedCallback = void Function(DateTime time);
typedef DateCancelledCallback = void Function();
typedef StringAtIndexCallBack = String? Function(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
    Widget? cancelWidget,
    String? title,
    double? hengMargin,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
          showTitleActions: showTitleActions,
          onChanged: onChanged,
          onConfirm: onConfirm,
          onCancel: onCancel,
          locale: locale,
          theme: theme,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          pickerModel: DatePickerModel(
            currentTimeParam: currentTime,
            maxTimeParam: maxTime,
            minTimeParam: minTime,
            locale: locale,
          ),
          cancelWidget: cancelWidget,
          title: title,
          hengMargin: hengMargin),
    );
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future<DateTime?> showTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    bool showSecondsColumn = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: TimePickerModel(
          currentTime: currentTime,
          locale: locale,
          showSecondsColumn: showSecondsColumn,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet with AM/PM.
  ///
  static Future<DateTime?> showTime12hPicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: Time12hPickerModel(
          currentTime: currentTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    DateTime? currentTime,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DateTimePickerModel(
          currentTime: currentTime,
          minTime: minTime,
          maxTime: maxTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static Future<DateTime?> showPicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale = LocaleType.en,
    BasePickerModel? pickerModel,
    picker_theme.DatePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: pickerModel,
      ),
    );
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    picker_theme.DatePickerTheme? theme,
    this.barrierLabel,
    this.locale,
    super.settings,
    BasePickerModel? pickerModel,
    this.cancelWidget,
    this.title,
    this.hengMargin,
  })  : pickerModel = pickerModel ?? DatePickerModel(),
        theme = theme ?? picker_theme.DatePickerTheme(),
        super();

  final bool? showTitleActions;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DateCancelledCallback? onCancel;
  final LocaleType? locale;
  final picker_theme.DatePickerTheme theme;
  final BasePickerModel pickerModel;
  final Widget? cancelWidget;
  final String? title;
  final double? hengMargin;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor {
    // 检测是否为横屏
    final context = navigator?.context;
    if (context != null) {
      final isHeng =
          MediaQuery.of(context).orientation == Orientation.landscape;
      return isHeng ? Colors.transparent : Colors.black54;
    }
    return Colors.black54;
  }

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // 横屏时点击透明区域关闭弹窗
          Navigator.of(context).pop();
        },
        child: _DatePickerComponent(
          onChanged: onChanged,
          locale: locale,
          route: this,
          pickerModel: pickerModel,
          cancelWidget: cancelWidget,
          title: title,
          hengMargin: hengMargin,
        ),
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}

class _DatePickerComponent extends StatefulWidget {
  const _DatePickerComponent({
    required this.route,
    required this.pickerModel,
    this.onChanged,
    this.locale,
    this.cancelWidget,
    this.title,
    this.hengMargin,
  });

  final DateChangedCallback? onChanged;

  final _DatePickerRoute route;

  final LocaleType? locale;

  final BasePickerModel pickerModel;

  final Widget? cancelWidget;

  final String? title;

  final double? hengMargin;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
//    print('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    picker_theme.DatePickerTheme theme = widget.route.theme;
    bool isHeng = MediaQuery.of(context).orientation == Orientation.landscape;
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          final double screenWidth = MediaQuery.of(context).size.height;
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(
                widget.route.animation!.value,
                theme,
                showTitleActions: widget.route.showTitleActions!,
                bottomPadding: bottomPadding,
                isHeng: isHeng,
                screenWidth: screenWidth,
              ),
              child: Material(
                // color: theme.backgroundColor,
                color: Colors.transparent,
                child: Container(
                  height: isHeng ? screenWidth : null,
                  margin: isHeng
                      ? EdgeInsets.only(left: widget.hengMargin ?? 0)
                      : null,
                  child: GestureDetector(
                    // 阻止内容区域的点击事件向外传播
                    onTap: () {},
                    child: _renderPickerView(theme),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.pickerModel.finalTime()!);
    }
  }

  Widget _renderPickerView(picker_theme.DatePickerTheme theme) {
    bool isHeng = MediaQuery.of(context).orientation == Orientation.landscape;
    Widget itemView = _renderItemView(theme);
    if (widget.route.showTitleActions == true) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(theme),
          // 横屏时让内容区域填满剩余空间
          isHeng ? Expanded(child: itemView) : itemView,
          Container(
              height: MediaQuery.of(context).padding.bottom,
              color: theme.backgroundColor),
        ],
      );
    }
    return itemView;
  }

  Widget _renderColumnView(
    ValueKey key,
    picker_theme.DatePickerTheme theme,
    StringAtIndexCallBack stringAtIndexCB,
    ScrollController scrollController,
    int layoutProportion,
    ValueChanged<int> selectedChangedWhenScrolling,
    ValueChanged<int> selectedChangedWhenScrollEnd,
    int viewIdx,
  ) {
    bool isHeng = MediaQuery.of(context).orientation == Orientation.landscape;
    return Expanded(
      flex: layoutProportion,
      child: Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        // 横屏时不限制高度，让它自动填充
        height: isHeng ? null : theme.containerHeight,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics =
                  notification.metrics as FixedExtentMetrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            backgroundColor: theme.backgroundColor,
            scrollController: scrollController as FixedExtentScrollController,
            itemExtent: theme.itemHeight,
            selectionOverlay: SizedBox(),
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: true,
            itemBuilder: (BuildContext context, int index) {
              final content = stringAtIndexCB(index);
              final nowIndex = getNowIndex(viewIdx);
              final isSelected = index == nowIndex;
              if (content == null) {
                return null;
              }
              return Container(
                height: theme.itemHeight,
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: isSelected
                      ? theme.itemStyle
                      : TextStyle(
                          color: Color(0xFF8F9BB2)
                              .withAlpha(getAlpha(index, nowIndex))),
                  textAlign: TextAlign.start,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int getNowIndex(int viewIdx) {
    switch (viewIdx) {
      case 0:
        return widget.pickerModel.currentLeftIndex();
      case 1:
        return widget.pickerModel.currentMiddleIndex();
      case 2:
        return widget.pickerModel.currentRightIndex();
    }
    return 0;
  }

  int getAlpha(int idx, int nowIdx) {
    int diff = (nowIdx - idx).abs();
    if (diff > 4) return 128;
    return (255 - (diff / 4) * (255 - 128)).round();
  }

  Widget _renderItemView(picker_theme.DatePickerTheme theme) {
    return Container(
      color: theme.backgroundColor,
      child: Stack(children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 64, height: 40),
              Container(
                child: widget.pickerModel.layoutProportions()[0] > 0
                    ? _renderColumnView(
                        ValueKey(widget.pickerModel.currentLeftIndex()),
                        theme,
                        widget.pickerModel.leftStringAtIndex,
                        leftScrollCtrl,
                        widget.pickerModel.layoutProportions()[0], (index) {
                        widget.pickerModel.setLeftIndex(index);
                      }, (index) {
                        setState(() {
                          refreshScrollOffset();
                          _notifyDateChanged();
                        });
                      }, 0)
                    : null,
              ),
              Text(
                widget.pickerModel.leftDivider(),
                style: theme.itemStyle,
              ),
              Container(
                child: widget.pickerModel.layoutProportions()[1] > 0
                    ? _renderColumnView(
                        ValueKey(widget.pickerModel.currentLeftIndex()),
                        theme,
                        widget.pickerModel.middleStringAtIndex,
                        middleScrollCtrl,
                        widget.pickerModel.layoutProportions()[1], (index) {
                        widget.pickerModel.setMiddleIndex(index);
                      }, (index) {
                        setState(() {
                          refreshScrollOffset();
                          _notifyDateChanged();
                        });
                      }, 1)
                    : null,
              ),
              Text(
                widget.pickerModel.rightDivider(),
                style: theme.itemStyle,
              ),
              Container(
                child: widget.pickerModel.layoutProportions()[2] > 0
                    ? _renderColumnView(
                        ValueKey(widget.pickerModel.currentMiddleIndex() * 100 +
                            widget.pickerModel.currentLeftIndex()),
                        theme,
                        widget.pickerModel.rightStringAtIndex,
                        rightScrollCtrl,
                        widget.pickerModel.layoutProportions()[2], (index) {
                        widget.pickerModel.setRightIndex(index);
                      }, (index) {
                        setState(() {
                          refreshScrollOffset();
                          _notifyDateChanged();
                        });
                      }, 2)
                    : null,
              ),
              SizedBox(width: 64, height: 40),
            ],
          ),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
                ignoring: true,
                child: Center(
                    child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border(
                                top: BorderSide(
                                    width: 0.5, color: Color(0xFFE6E8ED)),
                                bottom: BorderSide(
                                    width: 0.5, color: Color(0xFFE6E8ED))))))))
      ]),
    );
  }

  // Title View
  Widget _renderTitleActionsView(picker_theme.DatePickerTheme theme) {
    final done = _localeDone();
    final cancel = _localeCancel();
    final title = widget.title ?? '';
    bool isHeng = MediaQuery.of(context).orientation == Orientation.landscape;

    return ClipRRect(
        borderRadius: isHeng
            ? BorderRadius.zero
            : BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
        child: Container(
          height: theme.titleHeight,
          decoration: BoxDecoration(
            color: theme.headerColor ?? theme.backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.cancelWidget ??
                  SizedBox(
                    height: theme.titleHeight,
                    child: CupertinoButton(
                      pressedOpacity: 0.3,
                      padding: EdgeInsetsDirectional.only(start: 16, top: 0),
                      child: Text(
                        cancel,
                        style: theme.cancelStyle,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        if (widget.route.onCancel != null) {
                          widget.route.onCancel!();
                        }
                      },
                    ),
                  ),
              SizedBox(
                height: theme.titleHeight,
                child: Center(
                    child: Text(
                  title,
                  style: theme.titleStyle,
                )),
              ),
              SizedBox(
                height: theme.titleHeight,
                child: CupertinoButton(
                  pressedOpacity: 0.3,
                  padding: EdgeInsetsDirectional.only(end: 16, top: 0),
                  child: Text(
                    done,
                    style: theme.doneStyle,
                  ),
                  onPressed: () {
                    Navigator.pop(context, widget.pickerModel.finalTime());
                    if (widget.route.onConfirm != null) {
                      widget.route.onConfirm!(widget.pickerModel.finalTime()!);
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'] as String;
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'] as String;
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(
    this.progress,
    this.theme, {
    this.showTitleActions,
    this.bottomPadding = 0,
    this.isHeng = false,
    this.screenWidth = 0,
  });

  final double progress;
  final bool? showTitleActions;
  final picker_theme.DatePickerTheme theme;
  final double bottomPadding;
  final bool isHeng;
  final double screenWidth;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showTitleActions == true) {
      maxHeight += theme.titleHeight;
    }

    // 横屏时使用 screenWidth 作为高度，参考 live_game_log_black_panel.dart 的做法
    if (isHeng && screenWidth > 0) {
      maxHeight = screenWidth;
    }

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight + bottomPadding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress || isHeng != oldDelegate.isHeng;
  }
}
