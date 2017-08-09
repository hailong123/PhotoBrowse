//
//  PhotoManager.swift
//  Scroller
//
//  Created by SeaDragon on 2017/8/2.
//  Copyright © 2017年 SeaDragon. All rights reserved.
//

import UIKit

class PhotoManager: NSObject {

    static let shareInstance = PhotoManager()

    var phototShowView : CustomShowView
    
    override init() {
        
        self.phototShowView = CustomShowView()
        
        super.init()
    }
    
    public func photoShow(view: UIView,
                          photoNamesArr: [String],
                          index: Int,
                          delegate: Any,
                          converView:UIView,
                          contantView:UIView) {
        
        phototShowView.delegate   = delegate as? CustomShowViewDelegate
        phototShowView.isHidden   = true
        phototShowView.imageList  = photoNamesArr
        phototShowView.imageIndex = index
        
        phototShowView .showInView(view: view)
        
        let imgView = converView as! UIImageView
        
        var subFrame       = contantView.convert((converView.frame), to: view)
        
        let tmpImageView   = UIImageView.init(frame: subFrame)
        
        tmpImageView.image                 = imgView.image
        tmpImageView.backgroundColor       = UIColor.yellow
        
        UIApplication.shared.keyWindow?.addSubview(tmpImageView)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            subFrame = CGRect.init(x: 0,
                                   y:100,
                                   width: Int(UIScreen.main.bounds.size.width),
                                   height: Int(UIScreen.main.bounds.size.width))
            
            tmpImageView.frame = subFrame
            
        }) { (Bool) in
            
            tmpImageView.removeFromSuperview()
            
            self.phototShowView.isHidden = false
         
        }

    }
    
}
