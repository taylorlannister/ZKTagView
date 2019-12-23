//
//  ViewController.swift
//  TagViewDemo
//
//  Created by 刘志康 on 2019/12/19.
//  Copyright © 2019 刘志康. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tagView = XDTTagView.init(frame: self.view.bounds, lineBreak: false, rightAligned: false)
        self.view.addSubview(tagView)
        
        tagView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(50)
            make.leading.trailing.bottom.equalTo(self.view)
        }
        //最大显示标签数
        tagView.maxTagCount = 9999
        tagView.updateTagView(tagArray: ["水浒","1","三国演义","西游记","四方山","精致的文艺不是浪漫","大南山","东西冲","粗糙的宏大是浪漫","墨风扇","大龙线","火凤线","武功山","齐云山","天空没有翅膀的痕迹 但是我已经飞过"])
    }
}

