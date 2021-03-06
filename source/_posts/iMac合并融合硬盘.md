---
title: iMac合并融合硬盘
date: 2020-12-21 23:46:55
tags: 
- Mac
categories: 
- Mac
description:
---

官方文档：https://support.apple.com/zh-cn/HT207584

## 使用“终端”重新创建融合硬盘 

以下步骤将永久删除融合硬盘所含驱动器上储存的所有数据。在继续之前，请确保您进行了[备份](https://support.apple.com/zh-cn/HT201250)。 

### 如果您使用的是 macOS Mojave 或更高版本

1.  将 Mac 开机，然后立即按住 Command-R 以[通过 macOS 恢复功能启动](https://support.apple.com/zh-cn/HT201314)。在看到 Apple 标志或旋转的地球时松开这些键。
2.  当您看到“macOS 实用工具”窗口时，请从菜单栏中选取“实用工具”>“终端”。
3.  在“终端”窗口中键入 `diskutil resetFusion`，然后按 Return 键。
4.  在出现提示时键入 `Yes`（*Y* 需要大写），然后按 Return 键。
5.  当“终端”指示操作成功时，退出“终端”以返回“macOS 实用工具”窗口。
6.  选取“[重新安装 macOS](https://support.apple.com/zh-cn/HT204904)”，然后按照屏幕上的说明操作，以重新安装 Mac 操作系统。完成后，Mac 将从您的融合硬盘重新启动。
