//
//  CustomShowView.swift
//  Scroller
//
//  Created by SeaDragon on 2017/8/1.
//  Copyright © 2017年 SeaDragon. All rights reserved.
//

import UIKit

protocol CustomShowViewDelegate {
    func customShowViewDelegate(index: Int) -> CGRect;
}

class CustomShowView: UIView {
    
    public var imageList: [String] {
    
        didSet{
        
            scrollView.contentSize = CGSize.init(width: Int(Int(self.frame.size.width) * imageList.count), height: 0)
            
            self.createImage(imgList: imageList)
        }
        
    }
    
    public var imageIndex:Int {
    
        didSet {
        
            scrollView.setContentOffset(CGPoint.init(x: imageIndex*Int(self.frame.size.width), y: 0), animated: false)
            
        }
        
    }
    
    private var scrollView : UIScrollView!
    
    var delegate : CustomShowViewDelegate?
    
    var index : Int = 0
    
    override init(frame:CGRect) {
        
        self.imageIndex = 0
        self.imageList  = []
        
        super.init(frame: frame)
        
        self.createUI()
    }
    
    private func createUI() {
        
        self.frame = UIScreen.main.bounds
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 100, width: self.frame.size.width, height: self.frame.size.width))
    
        scrollView.bounces         = true
        scrollView.delegate        = self
        scrollView.isPagingEnabled = true
        
        scrollView.backgroundColor = UIColor.red
        
        self.addSubview(scrollView)
        
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hidden)))
    }
    
    
    private func createImage(imgList:[String]) {
    
        for item in 0..<imgList.count {
            
            let imgView = UIImageView()
            
            imgView.image = UIImage.init(named: imgList[item])
            
            imgView.frame = CGRect.init(x: Int(item*Int(self.frame.size.width)),
                                        y: 0,
                                        width:Int(self.frame.size.width),
                                        height:Int(self.frame.size.width))
            
            imgView.backgroundColor = UIColor.yellow
            
            scrollView.addSubview(imgView)
        }
        
    }
    
    public func showInView(view:UIView) {
        
        view.backgroundColor = UIColor.blue
        
        view .addSubview(self)
    
    }
    
    @objc private func hidden(tap :UITapGestureRecognizer) {
    
        self.removeFromSuperview()
        
        let tmpImageView = tap.view?.subviews[0].subviews[self.index] as! UIImageView
        
        let tmpFrame  = scrollView.convert((tmpImageView.frame), to: self)
        
        let ImgView   = UIImageView.init(frame: CGRect.init(x: 0,
                                                            y: tmpFrame.origin.y,
                                                            width: tmpFrame.size.width,
                                                            height: tmpFrame.size.height))
        
        ImgView.image           = tmpImageView.image
        ImgView.backgroundColor = UIColor.yellow
        
        UIApplication.shared.keyWindow?.addSubview(ImgView)
        
        UIView.animate(withDuration: 0.25, animations: { 
            
            var tmpFrameTwo = CGRect.zero
            
            if self.delegate != nil {
            
                tmpFrameTwo   = (self.delegate?.customShowViewDelegate(index: self.index))!
                ImgView.frame = tmpFrameTwo
                
            }
            
        }) { (Bool) in
            ImgView.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomShowView:UIScrollViewDelegate {

     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.index = (Int(scrollView.contentOffset.x)/Int(self.frame.size.width)) 

    }
    
}
