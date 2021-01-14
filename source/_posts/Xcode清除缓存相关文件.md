---
title: Xcode清除缓存相关文件
date: 2020-12-24 16:34:00
tags:
categories:
description:
---
参考文章：[Xcode清除缓存相关文件](https://www.jianshu.com/p/9c88b782c6dd)

## 可删
##### 1. 模拟器运行程序产生的数据(DerivedData)（可删）
`~/Library/Developer/Xcode/DerivedData`
##### 2. Xcode打包产生的app icon历史版本(Products)（可删）
`~/Library/Developer/Xcode/Products/`
##### 3. XCPGDevices(playground 项目缓存)（可删）
`~/Library/Developer/XCPGDevices/`

## 选删

##### 1. Xcode打ipa包的历史记录xcarchive文件（选删）
`~/Library/Developer/Xcode/Archives`
##### 2. 设备支持文件(DeviceSupport)（选删）
`~/Library/Developer/Xcode/iOS DeviceSupport`
##### 3. 证书描述文件（选删）
`~/Library/MobileDevice/Provisioning Profiles`
##### 4. 模拟器文件（选删）
`~/Library/Developer/CoreSimulator/Profiles/Devices/`