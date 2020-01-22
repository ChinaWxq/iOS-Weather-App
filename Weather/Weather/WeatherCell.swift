//
//  WeatherCell.swift
//  Weather
//
//  Created by Ryan on 2020/1/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    lazy var leftWeatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 40, y: 25, width: 30, height: 30))
        let image = #imageLiteral(resourceName: "0")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 10, width: 150, height: 60))
        label.font = UIFont(name: "Arial-BoldMT", size: 18)
        label.textAlignment = .left
        return label
    }()
    
    lazy var rightWeatherLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth - 150, y: 15, width: 100, height: 50))
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .orange
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(leftWeatherImageView)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(rightWeatherLabel)
    }
}

