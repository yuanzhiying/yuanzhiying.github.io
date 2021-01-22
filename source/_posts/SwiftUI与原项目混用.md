---
title: SwiftUI与原项目混用
date: 2021-01-22 13:33:45
tags: SwiftUI
categories: Swift
description:
---
`Swift`跳转到`SwiftUI`；以`Push`为例，`present`一样的，只不过是需要用`UIHostingController`初始化你的`SwiftUIView`。初始化出来的就是一个正常的`UIViewController`，正儿八经的控制器，怎么用都行。

示例代码：
```
if #available(iOS 13, *) {
            let testSwiftUIView = UIHostingController(rootView: TestSwiftUIView())
            navigationController?.pushViewController(testSwiftUIView, animated: true)

        }
```
