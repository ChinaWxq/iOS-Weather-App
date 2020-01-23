//
//  FifthTableViewCell.swift
//  Weather
//
//  Created by Ryan on 2020/1/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class FifthTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    lazy var leftTopLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 3, width: ScreenWidth / 2 - 20, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 25, width: ScreenWidth / 2 - 20, height: 20))
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var rightTopLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth / 2, y: 3, width: ScreenWidth / 2 - 20, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var rightBottomLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth / 2, y: 25, width: ScreenWidth / 2 - 20, height: 20))
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addSubview(leftTopLabel)
        self.addSubview(leftBottomLabel)
        self.addSubview(rightTopLabel)
        self.addSubview(rightBottomLabel)
    }
}
