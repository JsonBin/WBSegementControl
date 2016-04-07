# WBSegementControl
####swift 编写的一段标签控制器，自定义NavigationBar, 设置渐变颜色，并可根据实际情况设定需要显示的button个数

使用教程
=======
* 初始化
  
        // 初始化数据
        let array = NSArray.init(array: ["数码","手机","电视","空调","冰箱","电脑","电饭煲","电饭锅"])
        // 调用标题滚动按钮视图
        let topview = WBTitleScrollView.init(frame: CGRectMake(0, 0, getWidth(), 20+44), titlearray: array)
        // 添加到视图上
        topview.showInView(self.view)
        
        // 根据标题滚动的视图
        let sview = WBViewControlScrollView.init(frame: CGRectMake(0, 64, getWidth(), getHeight()-64), textArray: array)
        self.view.addSubview(sview)
* 点击标签跳转相应的页面
        
        weak var weakSelf = self // 弱引用
        // 点击button调用事件
        topview.initWithClick { (tag) in
            // 根据点击button的tag，跳转到相对于的界面
            sview.setContentOffset(CGPointMake((weakSelf?.getWidth())!*CGFloat(tag-200), 0), animated: true) // 设置滚动，true有动画显示
        }
* 滑动页面跳转相应的标签

        // 滑动view调用事件
        sview.initWithSwip { (offx) in
            let translation = sview.panGestureRecognizer.translationInView(sview.superview).x
            let precent = offx/(weakSelf?.getWidth())!  // 获取滑动的百分比
            if translation>0 {
                // 右滑
                topview.setRedViewCenter(false, precent: precent)
            }else{
                // 左滑
                topview.setRedViewCenter(true, precent: precent)
            }
        }
        
运行效果图
=========
 ![gif](https://github.com/JsonBin/WBSegementControl/raw/master/WBSegementControl/segement.gif "运行标签效果图")
