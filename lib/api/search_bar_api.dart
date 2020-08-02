import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchBarAPI extends AnimatedWidget {
  SearchBarAPI({
    Key key,
    @required Animation<double> animation,
    @required this.controller,
    @required this.focusNode,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onCancel;
  final Function onClear;
  final Function(String) onUpdate;
  final Function(String) onSubmit;

  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
  static final _defaultTextSize = 17.0;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                border:
                    new Border.all(width: 0.0, color: CupertinoColors.white),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
                        child: new Icon(
                          CupertinoIcons.search,
                          color: CupertinoColors.inactiveGray,
                          size: _defaultTextSize + 2.0,
                        ),
                      ),
                      new Text(
                        'Artists, songs, or albums',
                        style: new TextStyle(
                          inherit: false,
                          color: CupertinoColors.inactiveGray
                              .withOpacity(_opacityTween.evaluate(animation)),
                          fontSize: _defaultTextSize,
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: EditableText(
                            controller: controller,
                            focusNode: focusNode,
                            onChanged: onUpdate,
                            onSubmitted: onSubmit,
                            style: new TextStyle(
                              color: CupertinoColors.black,
                              inherit: false,
                              fontSize: _defaultTextSize,
                            ),
                            cursorColor: CupertinoColors.black,
                            backgroundCursorColor: CupertinoColors.white,
                          ),
                        ),
                      ),
                      new CupertinoButton(
                        minSize: 10.0,
                        padding: const EdgeInsets.all(1.0),
                        borderRadius: new BorderRadius.circular(30.0),
                        color: CupertinoColors.inactiveGray.withOpacity(
                          1.0 - _opacityTween.evaluate(animation),
                        ),
                        child: new Icon(
                          Icons.close,
                          size: 15.0,
                          color: CupertinoColors.white,
                        ),
                        onPressed: () {
                          if (animation.isDismissed)
                            return;
                          else
                            onClear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          new SizedBox(
            width: _paddingTween.evaluate(animation),
            child: new CupertinoButton(
              padding: const EdgeInsets.only(left: 8.0),
              onPressed: onCancel,
              child: new Text(
                'Cancel',
                softWrap: false,
                style: new TextStyle(
                  inherit: false,
                  color: CupertinoColors.activeBlue,
                  fontSize: _defaultTextSize - 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
