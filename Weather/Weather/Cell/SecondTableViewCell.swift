//
//  SecondTableViewCell.swift
//  Weather
//
//  Created by Ryan on 2020/1/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    var data: [LiveData] = Array<LiveData>(repeating: LiveData(), count: 24)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate let collcectionViewId = "LiveWeatherCell"

    lazy var liveWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 100)
        let collectionView = UICollectionView(frame: CGRect(x: 15, y: 0, width: ScreenWidth-40, height: 100), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: collcectionViewId)
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addSubview(liveWeatherCollectionView)
    }
}

extension SecondTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collcectionViewId, for: indexPath) as! CollectionViewCell
        cell.topTimeLabel.text = data[indexPath.row].nowTime
        cell.weatherImageView.image = UIImage(named: data[indexPath.row].imageCode)
        cell.bottomDegreeLabel.text = data[indexPath.row].degree
        return cell
    }
    
}

extension SecondTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
