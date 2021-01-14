---
title: SwiftUI学习
date: 2021-01-14 09:51:25
tags:
- Swift
- SwiftUI
categories:
- Swift
- SwiftUI
description:
---

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
2. 