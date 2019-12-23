//
//  XdtHotListTagCell.swift
//  XiaoDengTa
//
//  Created by 刘志康 on 2019/9/19.
//  Copyright © 2019 刘志康 All rights reserved.
//

import UIKit
import SnapKit
class XdtHotListTagCell: UICollectionViewCell {
    
    var tagLabel = UILabel.init()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        
        tagLabel.backgroundColor = UIColor_Extension.randomColor()
        tagLabel.textColor = UIColor_Extension.randomColor()
        tagLabel.backgroundColor = .orange
        tagLabel.font = UIFont.systemFont(ofSize: 10)
        tagLabel.textAlignment = .center
        
        self.addSubview(tagLabel)
        
        tagLabel.snp.makeConstraints { (make) in

            make.leading.trailing.equalTo(self)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
        }
    }
}
