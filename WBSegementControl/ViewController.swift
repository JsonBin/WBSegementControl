//
//  ViewController.swift
//  WBSegementControl
//
//  Created by Zwb on 16/4/6.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        naView()
        self.automaticallyAdjustsScrollViewInsets = false
        // 初始化标题
        let array = NSArray.init(array: ["数码","手机","电视","空调","冰箱","电脑","电饭煲","电饭锅"])
        // 调用标题滚动按钮视图
        let topview = WBTitleScrollView.init(frame: CGRectMake(0, 0, getWidth(), 20+44), titlearray: array)
        // 添加到视图上
        topview.showInView(self.view)
        
        // 根据标题滚动的视图
        let sview = WBViewControlScrollView.init(frame: CGRectMake(0, 64, getWidth(), getHeight()-64), textArray: array)
        self.view.addSubview(sview)
        
        weak var weakSelf = self // 弱引用
        // 点击button调用事件
        topview.initWithClick { (tag) in
            // 根据点击button的tag，跳转到相对于的界面
            sview.setContentOffset(CGPointMake((weakSelf?.getWidth())!*CGFloat(tag-200), 0), animated: true) // 设置滚动，true有动画显示
        }
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 重写navigationBar覆盖原来的，并设置颜色为渐变色
    func naView() -> Void {
        let view = UIView.init(frame: CGRectMake(0, 0, getWidth(), 64))
        let gradient = CAGradientLayer()
        gradient.bounds = view.bounds
        gradient.position = view.center
        gradient.colors = [UIColor.blueColor().CGColor, UIColor.cyanColor().CGColor]
        gradient.startPoint = CGPointMake(0, 1)
        gradient.endPoint = CGPointMake(0, 0)
        view.layer.addSublayer(gradient)
        self.view.addSubview(view)
    }
    
    func getWidth() -> CGFloat {
        return self.view.bounds.size.width
    }
    
    func getHeight() -> CGFloat {
        return self.view.bounds.size.height
    }
}

