---
title: Flutter、Dart学习总结
date: 2020-12-08 15:37:16
tags: [flutter]
---
- #### Container
添加 padding, margins, borders, background color, 或将其他装饰添加到widget
- #### Scaffold
使用Scaffold是最容易的，它是 Material Components库中的一个widget，它提供了一个默认banner，背景颜色，并且具有添加drawer，snack bar和底部sheet的API
- #### DefaultTextStyle
DefaultTextStyle.merge可以允许您创建一个默认的文本样式，该样式会被其所有的子节点继承
- #### maxCrossAxisExtent
[GridView.extent中maxCrossAxisExtent的作用](https://www.jianshu.com/p/8a142e06c48e)
- #### SizedBox
能强制子控件具有特定宽度、高度或两者都有,使子控件设置的宽高失效
```
        new SizedBox(
          width: 100.0,
          height: 100.0,
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Color(0xffff0000),
          ),
        )
```
- #### State状态管理
1. 如果状态是用户数据，如复选框的选中状态、滑块的位置，则该状态最好由父widget管理
2. 如果所讨论的状态是有关界面外观效果的，例如动画，那么状态最好由widget本身来管理
3. 如果有疑问，首选是在父widget中管理状态
- #### flutter的Key
[Flutter-->何时需要使用到key？](https://www.jianshu.com/p/fc88c0774078)
[flutter 中的 key](https://www.jianshu.com/p/3b2bc9f0ddd6)
- #### flutter的json转为实体类插件（Android Studio插件）
AS中搜索插件`FlutterJsonBeanFactory `，安装，重启AS。
在指定目录下，右键，new - dart bean class File From JSON，粘贴进json，格式化，生成即可。
![路径](https://upload-images.jianshu.io/upload_images/2988687-b38ed2f78df0bcec.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- #### dart中export使用
在A库中使用export关键字引入B库，当我们使用A库的时候，会自动引入B库，也就是说我们导入了A库，就可以使用B库了。
- #### cupertino下push的同时，隐藏tabbar
```
Navigator.of(context, rootNavigator: true)
          .push(CupertinoPageRoute(builder: (BuildContext context) {
        return new MsgCenterPage();
      }));
```
- #### flutter使用16进制色值
Color(0xFFFF8A65)其中0x后面的两位FF表示透明度16进制，FF后面为色值
- #### flutter获取屏幕宽高和状态栏高度
```
/** 获取屏幕宽度 */
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /** 获取屏幕高度 */
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /** 获取系统状态栏高度 */
  static double getSysStatsHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
```
- #### GestureDetector为布局添加手势，child和空白区域全部可点击
GestureDetector的child添加为Container，同时Container要设置color，整体Container的child和空白区域才全部可点击，否则则是Container的child可点而空白不可点击。
- #### 隐藏键盘
```
FocusScope.of(context).requestFocus(FocusNode());
```
- #### dynamic的使用
在数据解析过程中，如果不确定当前类型的话，可以使用dynamic来代替，具体是某个类型的话，再转为某个类型。
```

@JsonSerializable()
class ResultData extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'data')
  dynamic data;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'message')
  String message;

  ResultData(this.code,this.data,this.url,this.message,);

  factory ResultData.fromJson(Map<String, dynamic> srcJson) => _$ResultDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultDataToJson(this);

}
```
- #### flutter延迟执行
```
new Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
```
- #### flutter中url中编码解码
例如：需要将
`js://iOSAction?%7B%22method%22:%22toLogin%22%7D`
转为
`js://iOSAction?{"method":"toLogin"}`
使用Uri的decode方法：
`String url = Uri.decodeFull(navigation.url);`
相反，编码的话，使用Uri的encode方法。
- #### flutter的图片布局填充满父布局
```
方法一：
new ConstrainedBox(
                  constraints: new BoxConstraints.expand(),
                  child: new FadeInImage.assetNetwork(
                    placeholder: "assets/home/placeholder_default.png",
                    image: model != null
                        ? "${APIConfig.pictureURL}"
                        "${model.pictureUrl}"
                        : null,
                    fit: BoxFit.fill,
                  ),
                ),

方法二：
如果已知宽高，Image里直接定义指定的宽和高
MediaQuery.of(context).size.width
MediaQuery.of(context).size.height
```
- #### Text超出省略号截断
`TextOverflow.ellipsis`
```
new Text(
                  '我爱北京天安门，我爱北京天安门，我爱北京天安门，我爱北京天安门，我爱北京天安门，我爱北京天安门，我爱北京天安门',
                  overflow: TextOverflow.ellipsis,
                ),
```
- #### `list`通过`map`转化的时候获取`index`
`list`通过`asMap`转为`Map`，然后使用`Map.map`获取`index`。
```
    homeNoticeList
        .asMap()
        .map((index, model) => MapEntry(
              index,
              new GestureDetector(
                onTap: () {
                  logPrint(index, message: "我点击了滚动的广告");
                },
                child: new Container(
                  color: ColorConfig.white,
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      model.title,
                      style: new TextStyle(fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ))
        .values
        .toList();
```
- #### `Cookie`管理
网络请求使用dio进行网络请求，可以添加cookiemanager拦截器，来对cookie进行自动管理，也可手动删除cookie。
Flutter中添加依赖
```
  dio: ^2.1.7 # 网络请求
  cookie_jar: ^1.0.0 # cookie管理
```
dio请求封装中，添加拦截器：
```
// 添加`Cookie`管理
    dio.interceptors.add(CookieManager(CookieJar()));
```
然后在`request`的`headers`中会自动增加
```
cookie: SESSION=9d41c3e9-5619-492f-aa92-d85add6b04ed
```
与`iOS`的`moya` `cookie`不一样，一个是`cookie`，一个是`"Set-Cookie"`（header中拼入）：
```
["Set-Cookie":SESSION=9d41c3e9-5619-492f-aa92-d85add6b04ed]
```
- #### `Appbar`中使用自定义的返回按钮
先设置`automaticallyImplyLeading`为`false`，然后在`leading`中设置返回按钮。
  ```
automaticallyImplyLeading: false,
        leading: new GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: new Image.asset('assets/common/nav_back_arrow.png'),
        ),
```
- #### 设置appbar高度
```
appBar: new PreferredSize(
        child: appBar,
        preferredSize: Size.fromHeight(44),
      ),
```
- #### 使用`webview_flutter`时执行调用`js`的方法：
推荐在`onPageFinished`里调用。
例如：
```
onPageFinished: (String url) {
                      print("page finished loading: $url");
                      setState(() {
                        isLoading = false;
                      });

                      // 如果为项目风险等级的url，则执行隐藏header的js。
                      if (widget.url == ContentConfig.projectRiskLevel) {
                        _controller.future.then((controller) {
                          controller
                              .evaluateJavascript('hideHeader();')
                              .then((result) {});
                        });
                      }
                    }
```
- #### `android studio`中使用`print`打印，只能打印出一部分的解决办法：
导入`foundation`库：
`import 'package:flutter/foundation.dart';`
使用`flutter`里`foundation`中的`debugPrint`打印即可打印全部。
- #### TabBar对应的TabController使用代码切换tabBar (index从0开始)：
```
controller.animateTo(index);
```
- #### flutter富文本RichText使用
[RichText在段落中显示不同样式](https://www.jianshu.com/p/c4ee2a7a97d2)
- #### 复制到粘贴板
```
import 'package:flutter/services.dart';

  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }
```
- #### 返回当前的时间戳
```
static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
```
- #### 返回文件大小字符串
```
static const RollupSize_Units = ["GB", "MB", "KB", "B"];
  /** 返回文件大小字符串 */
  static String getRollupSize(int size) {
    int idx = 3;
    int r1 = 0;
    String result = "";
    while (idx >= 0) {
      int s1 = size % 1024;
      size = size >> 10;
      if (size == 0 || idx == 0) {
        r1 = (r1 * 100) ~/ 1024;
        if (r1 > 0) {
          if (r1 >= 10)
            result = "$s1.$r1${RollupSize_Units[idx]}";
          else
            result = "$s1.0$r1${RollupSize_Units[idx]}";
        } else
          result = s1.toString() + RollupSize_Units[idx];
        break;
      }
      r1 = s1;
      idx--;
    }
    return result;
  }
```
- #### flutter调起拨打电话
```
import 'package:url_launcher/url_launcher.dart';

Future<void> _launched;

Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// 调起拨打电话
          setState(() {
            _launched = _makePhoneCall('tel:18612345678');
          });
```
- #### 垂直分割线
```
Container(
                  height: 40,
                  child: VerticalDivider(color: Colors.red),
                ),
```
- #### 可取消的定时任务
Timer代替Future.
