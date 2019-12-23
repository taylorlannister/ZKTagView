//
//  XDTTagView.swift
//  XiaoDengTa
//
//  Created by 刘志康 on 2019/9/18.
//  Copyright © 2019 刘志康 All rights reserved.
//

import UIKit
import SnapKit


class XDTTagView: UIView{
    
    var tagArray:Array<String> = []
    
    var collectionView :UICollectionView?
    //最大显示标签数
    var maxTagCount = 3
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
//    NSTextAlignment
    init(frame: CGRect, lineBreak:Bool = false, rightAligned:Bool = false) {
        
        super.init(frame: frame)
        
        let layout = MLHorizontalCollectionViewFlowLayout.init()
        layout.horizonalType = rightAligned == true ? MLHorizonalRight : MLHorizonalLeft
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        let  collectionView = UICollectionView.init(frame:self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(XdtHotListTagCell.self, forCellWithReuseIdentifier: "XdtHotListTagCell")
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            
            make.leading.trailing.top.bottom.equalTo(self)
        }
        self.collectionView = collectionView
    }
    func updateTagView(tagArray:Array<String>){
        self.tagArray = tagArray
        collectionView?.reloadData()
    }
    
    class func getCellItemSize(str:String) -> CGSize{
        let size = str.textSizeWithFont(font: UIFont.systemFont(ofSize: 10), maxHeight: 15)
        return CGSize(width: size.width+10, height: 15)
    }
}

extension XDTTagView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if tagArray.count > maxTagCount {
            return maxTagCount
        }
        
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: XdtHotListTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XdtHotListTagCell", for: indexPath) as! XdtHotListTagCell
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = true
        cell.tagLabel.text = tagArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return XDTTagView.getCellItemSize(str: tagArray[indexPath.row])
    }
}
