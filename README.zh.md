# HcdProcessView
A concise water wave animation process view.

[![Version](https://img.shields.io/cocoapods/v/HcdProcessView.svg?style=flat)](http://cocoapods.org/pods/HcdProcessView)
[![Platform](https://img.shields.io/cocoapods/p/HcdProcessView.svg)](http://cocoapods.org/pods/HcdProcessView)
[![License](https://img.shields.io/github/license/Jvaeyhcd/HcdProcessView.svg)](http://cocoapods.org/pods/HcdProcessView)
[![Tag](https://img.shields.io/github/tag/Jvaeyhcd/HcdProcessView.svg
)](http://cocoapods.org/pods/HcdProcessView)
[![Author](https://img.shields.io/badge/author-Jvaeyhcd-f07c3d.svg)](http://www.jvaeyhcd.cc)

## 前言

最近一个项目中设计了一个带有双波浪的圆形进度显示控件，首先看到设计的效果后，我先在网上查阅了相关资料。其中有一个的效果还不错，但是通过查看源码分析后发现，这是一个由两张图片做成的动画效果。虽然这个实现了圆形双波浪的进度显示，但是明显是达不到我想要的效果的。所有我决定自己编写一个这样的控件，于是就产生了HcdProcessView。

## 效果
首先来一张如下动态效果图：

![这里写图片描述](http://img.blog.csdn.net/20160914140258838)

## HcdProcessView特性
* 使用纯代码编写，不需要用到图片
* 可自定义波浪颜色
* 可以自定义刻度颜色

## Requirements
* Xcode6或更高版本
* iOS7或更高版本
* ARC

## 使用方法
本工程源码我放在了Github上：[https://github.com/Jvaeyhcd/HcdProcessView](https://github.com/Jvaeyhcd/HcdProcessView)

### 常规方法
将Github上的源码下载下来，然后将`HcdProcessView`文件夹下的所有文件拷贝到您的项目中，在需要使用`HcdProcessView`的地方`#include "HcdProcessView.h"`。

### Cocoapods
当然我也提供了使用cocoapods安装的方法，在您项目工程的podfile文件中添加“pod HcdProcessView”, 然后pod install。

> 注意：如果通过pod无法导入`HcdProcessView`请先更新您的cocoapods的Spec仓库，先`pod setup`然后再`pod install`。


### 示例
在需要使用此控件的地方按照如下方式显示即可：
```
HcdProcessView *customView = [[HcdProcessView alloc] initWithFrame:
                                  CGRectMake(self.view.frame.size.width * 0.1, 70,
                                             self.view.frame.size.width * 0.8,
                                             self.view.frame.size.width * 0.8)];
customView.percent = 0.6;
customView.showBgLineView = YES;

[self.view addSubview:customView];
```

## Contact
如果您在使用的过程中有什么意见或者建议可以直接给我提交 [issue](https://github.com/Jvaeyhcd/HcdProcessView/issues/new).

## LICENSE

MIT License.
