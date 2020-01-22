//
//  CollectionViewCell.swift
//  Weather
//
//  Created by Ryan on 2020/1/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.addSubview(topTimeLabel)
        self.addSubview(weatherImageView)
        self.addSubview(bottomDegreeLabel)
    }
    
    lazy var topTimeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 8, width: 70, height: 20))
        label.font = UIFont.systemFont(ofSize: 16)
        //label.text = "下午8时"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 28, y: 40, width: 20, height: 20))
        //imageView.image = #imageLiteral(resourceName: "16")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bottomDegreeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 75, width: 70, height: 20))
        label.font = UIFont.systemFont(ofSize: 16)
        //label.text = "8"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
}
