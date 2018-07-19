# HcdProcessView
A concise water wave animation process view.

[![Version](https://img.shields.io/cocoapods/v/HcdProcessView.svg?style=flat)](http://cocoapods.org/pods/HcdProcessView)
[![Platform](https://img.shields.io/cocoapods/p/HcdProcessView.svg)](http://cocoapods.org/pods/HcdProcessView)
[![License](https://img.shields.io/github/license/Jvaeyhcd/HcdProcessView.svg)](http://cocoapods.org/pods/HcdProcessView)
[![Tag](https://img.shields.io/github/tag/Jvaeyhcd/HcdProcessView.svg
)](http://cocoapods.org/pods/HcdProcessView)
[![Author](https://img.shields.io/badge/author-Jvaeyhcd-f07c3d.svg)](http://www.jvaeyhcd.cc)
[![Codewars](https://www.codewars.com/users/Jvaeyhcd/badges/small)](https://www.codewars.com/users/Jvaeyhcd)

![Example](https://github.com/Jvaeyhcd/HcdProcessView/blob/master/screen.gif?raw=true)

## Requirements
* Xcode 6 or higher
* iOS 7.0 or higher
* ARC

## How to use

### Manual Install
All you need to do is drop `HcdProcessView` files into your project, and add `#include "HcdProcessView.h"` to the top of classes that will use it.

### CocoaPods
```
pod 'HcdProcessView'
```

### Example
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
If you have some suggest please post me an [issue](https://github.com/Jvaeyhcd/HcdProcessView/issues/new).

## LICENSE

MIT License.
