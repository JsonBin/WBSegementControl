//
//  WBViewControlScrollView.swift
//  WBSegementControl
//
//  Created by Zwb on 16/4/6.
//  Copyright © 2016年 zwb. All rights reserved.
//

import UIKit
typealias SWIP=(offx:CGFloat)->Void

class WBViewControlScrollView: UIScrollView , UIScrollViewDelegate{

    var textarray = NSArray()
    // 声明两个手势的闭包
    var Swip:SWIP?
    
    // 初始化
    func initWithSwip(swip:SWIP)->Void{
        Swip = swip
    }
    
    init(frame: CGRect, textArray:NSArray) {
        super.init(frame: frame)
        textarray = textArray
        
        self.showsHorizontalScrollIndicator = false
        self.pagingEnabled = true
        self.delegate = self;
        self.contentSize = CGSizeMake(getWidth()*CGFloat(textarray.count), 0)
        
        // 可根据实际情况添加相应的View
        for index in 0..<textarray.count {
            view(index+300)
        }
    }
    
    func view(tag:NSInteger) -> Void {
        let view = UIView.init()
        view.bounds = CGRectMake(0, 0, getWidth(), getHeight())
        view.center = CGPointMake(getWidth()/2+getWidth()*(CGFloat(tag)-300), getHeight()/2)
        view.backgroundColor = UIColor.whiteColor()
        view.tag = tag
        self.addSubview(view)
        
        let label = UILabel.init()
        label.bounds = CGRectMake(0, 0, getWidth(), 100)
        label.textColor = UIColor.blackColor()
        label.center = view.center
        label.textAlignment = NSTextAlignment.Center
        label.text = textarray[(tag-300)] as? String
        self.addSubview(label)
    }

    //MARK  UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let off_x = scrollView.contentOffset.x
        if (Swip != nil) {
            Swip!(offx:off_x)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "press")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    }
    
    func getWidth() -> CGFloat {
        return self.bounds.size.width
    }
    
    func getHeight() -> CGFloat {
        return self.bounds.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
