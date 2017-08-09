//
//  ViewController.swift
//  Scroller
//
//  Created by SeaDragon on 2017/8/1.
//  Copyright © 2017年 SeaDragon. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var _nameList : [String] = []
    
    let contantView          = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //创建视图
        self.createUI()
    }
    
    //Private Method
    func createUI() {
        
        contantView.frame           = CGRect.init(x: 50,
                                                  y: 100,
                                                  width: self.view.frame.size.width - 2 * 50,
                                                  height: 300)
        
        contantView.backgroundColor = UIColor.blue
        
        self.view.addSubview(contantView)
        
        //创建视图
        _nameList = ["icon_contact_add_crm",
                     "icon_contact_chat_details_crm",
                     "icon_contact_friends_editor_add_group_crm",
                     "icon_contact_from_crm",
                     "icon_contact_group_chat_crm",
                     "icon_coontact_delete_crm",
                     "icon_coontact_phone_crm",
                     "icon_coontact_remarks_crm",
                     "icon_coontact_share_crm"]
        
        let wth = self.view.frame.size.width - 2 * 50
        
        for index in (0..<_nameList.count) {
            
            let picture   = UIImageView()
            picture.tag   = index
            picture.image = UIImage.init(named: _nameList[index])
            
            picture.backgroundColor = UIColor.yellow
            
            contantView.addSubview(picture)
            picture.isUserInteractionEnabled = true
            
            picture.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
            
            picture.frame = CGRect.init(x: index%3 * (195/3 + 20) + 20,
                                        y: index/3 * (195/3 + 20) + 20,
                                        width:Int((wth-(20*4))/3),
                                        height:Int((wth-(20*4))/3))
            
        }
        
    }
    
    func click(tap : UITapGestureRecognizer)  {

        let photoManager = PhotoManager.shareInstance
        
        photoManager.photoShow(view: self.view,
                               photoNamesArr: _nameList,
                               index: tap.view?.tag ?? 0,
                               delegate: self,
                               converView: tap.view!,
                               contantView: contantView)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: CustomShowViewDelegate {

    func customShowViewDelegate(index: Int) -> CGRect {
        
        let tmpImageView = contantView.subviews[index]
        let tmpRect      = contantView.convert(tmpImageView.frame, to: self.view)
        
        return tmpRect
    }
    
}

