//
//  ThirdTableViewCell.swift
//  Weather
//
//  Created by Ryan on 2020/1/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    lazy var leftDayLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 80, height: 40))
        label.text = dayInWeek(NSDate().dayOfWeek())
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: ScreenWidth / 2 - 10, y: 10, width: 20, height: 20))
        //imageView.image = #imageLiteral(resourceName: "16")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var highTemperatureLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth - 80, y: 0, width: 30, height: 40))
        label.font = UIFont.systemFont(ofSize: 16)
        //label.text = "8"
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    lazy var LowTemperatureLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth - 60, y: 0, width: 30, height: 40))
        label.font = UIFont.systemFont(ofSize: 16)
        //label.text = "6"
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(leftDayLabel)
        self.addSubview(weatherImageView)
        self.addSubview(highTemperatureLabel)
        self.addSubview(LowTemperatureLabel)
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

}
