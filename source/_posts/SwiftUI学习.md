---
title: SwiftUI学习
date: 2021-01-14 09:51:25
tags:
- Swift
- SwiftUI
categories:
- Swift
description:
---

学习文章：
[SwiftUI对比Flutter](https://blog.csdn.net/weixin_33701617/article/details/93164551?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-2.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-2.control)
[八个常见的SwiftUI误用及对应的正确打开方式](https://zhuanlan.zhihu.com/p/343549752)
[SwiftUI 基础之 Identifiable](https://www.jianshu.com/p/8d5e0f80856b)
[SwiftUI - Data Binding注解](https://www.jianshu.com/p/a2a69fb070b0)

- `SwiftUI`要求
1. iOS13.0+

###### 快捷键
1. control + option + 点击：出现属性编辑器
2. command + 点击：出现快捷菜单

###### 布局
1. VStack - 垂直布局
2. HStack - 水平布局
3. Spacer - 间距
4. Text - 文本
5. Image - 图片
6. Divider - 分割线
7. Group - 预览窗口预览多个
8. ScrollView - 滚动视图
9. Path - 路径
10. Shaper - 形状

###### 代码解析
```
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .font(.title)
            .foregroundColor(.yellow)
            .bold()
            .italic()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
1. `ContentView`为布局，`ContentView_Previews`为预览布局
2. `body`为计算属性，类型为不透明类型的`View`，不透明类型使用`some`修饰
3. `Swift`语法，只有一行代码，`return`可以省略
4. `some`修饰，表示不透明类型，总会返回某一个特定的类型，但是不知道是哪一种
> 1. 可以返回关联类型的协议类型
> 2. 安全性：不对外暴露具体的返回类型
> 3. 用来解决`SwiftUI`繁琐的不确定返回类型问题

###### 使用技巧
1. 可以在右上角+里拖动空间到代码中
2. 使用`import`导入所需的库
3. 可以新建`SwiftUI View`
4. `ignoresSafeArea`忽略`safeArea`的边距，用在`feame`前
5. 布局group组件可增加`padding`
6. `VStack`可添加`font`、`foregroundColor`等属性，对所有包含的元素起效
7. 串联属性，每一个点语法属性，返回当前对象
```
Text("Hello world!")
   .font(.title)
   .foregroundColor(.purple)
   
A modifier returns a view that applies a new behavior or visual change. You can chain multiple modifiers to achieve the effects you need.
```
8. 使用`previewLayout`可以定义预览的窗口的大小，也可以使用`Group`同时预览多个窗口，通用属性可以提取到外面
```
struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkRow(landmark: landmarks[0])
            LandmarkRow(landmark: landmarks[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
```
9. `Identifiable`：作为唯一标识
遍历需要唯一标识来遍历，如下：
```
List(landmarks, id: \.id) { landmark in
    NavigationLink(
        destination: LandmarkDetail()) {
        LandmarkRow(landmark: landmark)
    }
}
```
如果让列表中元素遵守`Identifiable`协议，遍历处即可省略`id`参数，model中需要有名称为`id`的属性
```
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
```
10. 页面跳转使用`NavigationLink`，`destination`为要跳转的页面
```
NavigationLink(destination: LandmarkDetail()) {
    LandmarkRow(landmark: landmark)
}
```
11. 使用`NavigationView`为页面田健导航栏，可设置 `navigationTitle`等
```
NavigationView {
    List(landmarks) { landmark in
        NavigationLink(destination: LandmarkDetail()) {
            LandmarkRow(landmark: landmark)
        }
    }
    .navigationTitle("Landmarks")
}
```
12. 预览窗口按钮作用：
第一个按钮：`Live Preview` 和`Debug Preview`，未打开只能查看页面，不能点击等，打开之后可以点击跳转页面等交互操作
第二个按钮：`Preview On Device`，连上真机点击之后，预览可以同步在真机上展示
第三个按钮：`Inspect Preview`，可以打开窗口属性窗口，可以设置预览窗口属性
第四个按钮：`Duplicate Preview` ，可以复制创建多个预览窗口
13. 代码控制预览的机型
```
struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
    }
}

// 多设备同时预览
struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 8", "iPhone 12 Pro Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
```
14. 组合静态的`View`和动态的`view`到`List`里，可使用`List + ForEach`：
```
List(filteredLandmarks) { landmark in
    NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
        LandmarkRow(landmark: landmark)
    }
}

替换为

List {
    Toggle(isOn: $showFavoriteOnly) {
        Text("Favorites only")
    }
    ForEach(filteredLandmarks) { landmark in
        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
            LandmarkRow(landmark: landmark)
        }
    }
}
```
如果遍历的对象没有实现`Identifiable`协议，则需要传`id`
```
List {
    ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
        Text(key)
    }
}
```
15. `ObservableObject`协议
当遵守`ObservableObject`协议的数据更新时，绑定数据的`view`会自动更新
```
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
}
```

16. `@Published`
使用`@Published`修饰监听对象的属性，表示该对象的属性需要把属性值的改变更新进去
```
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
}
```
17. `@StateObject`
使用`@StateObject`初始化一个监听对象的数据，
使用`.environmentObject`把数据设置到环境对象里，
在需要的地方去取环境对象`@EnvironmentObject var modelData: ModelData`进行使用

```
@main
struct MySwiftUIApp: App {
    // 定义
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // 设置
                .environmentObject(modelData)
        }
    }
}

// 取
@EnvironmentObject var modelData: ModelData

// 使用
modelData.landmarks
```
18. `Bool`的`toggle()`方法：在`true`和`false`之前切换
19. `@EnvironmentObject`属性用于在下级view中接收传递过来的参数
20. `environmentObject(_:) `方法用于向下级传递参数
21. `@Binding`：绑定修饰符用于修饰一个值，这个值用来改变另外一个值
```
绑定：
@Binding var isSet: Bool

修改：
FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
```
22. 定义有状态的字段，使用`@State`修饰，定义为`private`，并且赋初始值
`@State private var showFavoritesOnly = false`
21. `@State`：
使用@State属性为应用程序中的数据建立一个真实来源，您可以从多个视图中修改这些数据。SwiftUI管理底层存储并根据值自动更新视图。
22. 使用`Path`直接绘制，可以当做View来使用
23. `View`动画，包括颜色、透明度、旋转、大小和其他属性等，可以使用`withAnimation`来包裹状态State实现动画
```
withAnimation {
    self.showDetail.toggle()
}

withAnimation(.easeInOut(duration: 4)) {
    self.showDetail.toggle()
}
```
24. 调用`View`的`transition`可以为`View`添加动画
`HikeDetail(hike: hike).transition(.slide)`
自定义`transition`可自定义动画
```
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.slide
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.move(edge: .trailing)
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
```
25. `ListRowInsets`用来调整一个view在lsit中的上下左右间距
26. `CaseIterable`，用在`enum`中用来获取`allCases`方法
27. `@Environment`，SwiftUI提供了在环境中值的存储，使用`@Environment`可以访问值，并可以读写
```
@Environment(\.editMode) var editMode
```
28. `@State` 、`@ObservableObject`、`@Binding`、`@EnvironmentObject`区别
@State和@ObservableObject之间有一些细微的差异。这些都是很重要的，因为它们都有不同的用途。
@State在视图本地。值或数据在视图中本地保存。它由框架管理，由于它存储在本地，因此它是一个值类型。
@ObservableObject在视图外部，并且不存储在视图中。它是一种引用类型，因为它不在本地存储，而只是具有对该值的引用。这不是由框架自动管理的，而是开发人员的责任。这最适用于外部数据，例如数据库或由代码管理的模型。
@Binding也在视图内，但是与@State区别在于@Binding用于不通视图之间的参数传递。@Binding和@ObservedObbjecg一样都是传递引用。
@EnvironmentObject 可以理解为全局变量
29. `ObservableObject`和`@Published`
遵循 ObservableObject 协议的类可以使用 SwiftUI 的 @Published 属性包装器来自动发布属性的变化，以便使用该类的实例的任何视图能够自动重新调用 body 属性，保持界面与数据的一致。
`@Published var profile = Profile.default`
界面中使用`@Binding`来绑定UI
``
30. 使用`UIViewRepresentable`来将`UIKit`中已有的`View`在`SwiftUI`中使用
使用`UIViewControllerRepresentable`来`UIKit`中的`UIViewController`在`SwiftUI`中使用
[UIViewRepresentable](https://www.jianshu.com/p/384867321b67)
使用方法如下：
```
import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}
```
