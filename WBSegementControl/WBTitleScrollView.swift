//  WBTitleScrollView.swift
//  WBSegementControl
//
//  Created by Zwb on 16/4/6.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit
typealias TAG=(tag:NSInteger)->Void  // 相当于OC的typedef

class WBTitleScrollView: UIScrollView{
    
    let count = 5  // 可根据实际情况设定一排能够显示的button为多少个，默认为5个
    var titleArray  = NSArray() // 按钮的标题
    let redView     = UIView()
    var centerX     = CGFloat() // 记录redView的中心x
    var didClick    = Bool()    // 记录是否是点击
    
    
    // 声明闭包，以便调用
    var click:TAG?
    
    // 初始化闭包
    func initWithClick(click1:TAG) {
        click = click1
    }
    
    init(frame: CGRect, titlearray:NSArray) {
        super.init(frame: frame)
        titleArray = titlearray
        self.backgroundColor = UIColor.clearColor()
        self.showsHorizontalScrollIndicator = false
        self.contentSize = CGSizeMake(buttonWidth()*CGFloat(titleArray.count), 1)
        // 添加按钮
        for index in 0..<titleArray.count {
            button(200+index)
        }
        // 添加一个指示器
        redView.bounds = CGRectMake(0, 0, buttonWidth(), 2)
        redView.center = CGPointMake(buttonWidth()/2, 20+44-1)
        redView.backgroundColor = UIColor.redColor()
        self.addSubview(redView)
        centerX = redView.center.x
    }
    
    func showInView(view:UIView) -> Void {
        view.addSubview(self)
    }
    
    // 设置滚动条的中心位置 true向左滑，false右滑
    func setRedViewCenter(flag:Bool, precent:CGFloat) -> Void {
        // 点击时不调用，不能移动，移动结束之后能左右滑动
        if NSUserDefaults.standardUserDefaults().boolForKey("press") {
           return
        }
        let x = buttonWidth()*precent
        redView.center = CGPointMake(centerX+x, 20+44-1)
        if flag {
            if redView.center.x>getWidth() {
                // 向左滚动显示
                self.scrollRectToVisible(CGRectMake(x, 0, buttonWidth(), getHeight()), animated: true)
            }
        }else{
            if redView.center.x>getWidth() {
                // 向右滚动显示
                self.scrollRectToVisible(CGRectMake(x, 0, buttonWidth(), getHeight()), animated: true)
            }else{
                self.setContentOffset(CGPointMake(0, 0), animated: true)
            }
        }
    }
    
    // 自定义按钮
    func button(tag:NSInteger) -> Void {
        let  width = buttonWidth()
        let button = UIButton.init(type: UIButtonType.Custom)
        button.bounds = CGRectMake(0, 0, width, 44)
        button.center = CGPointMake((CGFloat(tag)-200)*width+width/2, 44)
        button.setTitle(titleArray[(tag-200)] as? String, forState:UIControlState.Normal)
        button.backgroundColor = UIColor.clearColor()
        button.tag = tag
        button.addTarget(self, action:#selector(WBTitleScrollView.action(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    
    func action(sender:UIButton) -> Void {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "press")
        weak var weakSelf = self // 弱引用
        UIView.animateWithDuration(0.2, animations: { 
            weakSelf?.redView.center = CGPointMake(sender.center.x, 20+44-1)
        })
        
        // 闭包回调
        if (click != nil) {
            click!(tag: sender.tag)
        }
        
    }
    
    // 返回每个按钮的宽度
    func buttonWidth() -> CGFloat {
        var width = CGFloat()
        if titleArray.count>count {
            width = getWidth()/CGFloat(count)
        }else{
            width = getWidth()/CGFloat(titleArray.count)
        }
        return width
    }
    
    func getWidth() -> CGFloat {
        return self.bounds.size.width
    }
    
    func getHeight() -> CGFloat {
        return self.bounds.size.height
    }
    
    // 改变背景色，渐变
    func backColor() -> Void {
        let gradient = CAGradientLayer()
        gradient.bounds = self.bounds
        gradient.position = self.center
        gradient.colors = [UIColor.blueColor().CGColor, UIColor.cyanColor().CGColor]
        gradient.startPoint = CGPointMake(0, 1)
        gradient.endPoint = CGPointMake(0, 0)
        self.layer.addSublayer(gradient)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
