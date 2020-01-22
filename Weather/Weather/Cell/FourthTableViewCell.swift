//
//  FourthTableViewCell.swift
//  Weather
//
//  Created by Ryan on 2020/1/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class FourthTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: ScreenWidth - 100, height: 70))
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "今天：当前多云。气温8；预计最高\n气温8。"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(label)
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
