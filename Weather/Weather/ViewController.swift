//
//  ViewController.swift
//  Weather
//
//  Created by Ryan on 2020/1/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HandyJSON
import CoreLocation

let Frame = UIScreen.main.bounds
let ScreenWidth = Frame.width
let ScreenHeight = Frame.height

class ViewController: UIViewController {
    
    fileprivate let id = "weatherCell"
    
    fileprivate var city: String? {
        didSet {
            let parameter1: Parameters = ["key":"SJSVidYf39dI84d0s", "location": self.city!, "language":"zh-Hans", "unit":"c", "start":"0", "days":"3"]
            Alamofire.request("https://api.seniverse.com/v3/weather/daily.json?", method: .get, parameters: parameter1, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if let obj = JSONDeserializer<ThreeDaysWeatherModel>.deserializeFrom(json: json.debugDescription) {
                        self.data = obj
                        //print(self.data)
                    }
                }
            }
            
            let parameter2: Parameters = ["key":"SJSVidYf39dI84d0s", "location": self.city!,"language":"zh-Hans","unit":"c"]
            Alamofire.request("https://api.seniverse.com/v3/weather/now.json?", method: .get, parameters: parameter2, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    //print(json)
                    if let obj = JSONDeserializer<TodayWeatherModel>.deserializeFrom(json: json.debugDescription) {
                        self.currentWeatherLabel.text = String(obj.results?[0].now?.temperature ?? "0") + "℃"
                    }
                }
            }
        }
    }
    
    func setupView() {
        self.view.addSubview(backImageView)
        self.view.addSubview(tableView)
        self.view.addSubview(cityLabel)
        self.view.addSubview(currentWeatherLabel)
    }
    
    fileprivate var data: ThreeDaysWeatherModel? {
        didSet {
            var count = 0
            for cell in tableView.visibleCells {
                let item = cell as! WeatherCell
                item.rightWeatherLabel.text = String(self.data?.results?[0].daily?[count].low ?? "Nav") + "℃ ~ " + String(self.data?.results?[0].daily?[count].high ?? "Nav") + "℃"
                item.leftWeatherImageView.image = UIImage(named: String(self.data?.results?[0].daily?[count].code_day ?? "1"))
                count += 1
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.7))
        let image = #imageLiteral(resourceName: "background")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: ScreenHeight * 0.7, width: ScreenWidth, height: ScreenHeight * 0.3))
        tableView.register(WeatherCell.classForCoder(), forCellReuseIdentifier: id)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.delegate = self
        return tableView
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth - 150, y: ScreenHeight * 0.50, width: 150, height: ScreenHeight * 0.08))
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        //label.text = "Huangshi"
        return label
    }()
    
    lazy var currentWeatherLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth - 130, y: ScreenHeight * 0.58, width: 100, height: ScreenHeight * 0.10))
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = .white
        label.textAlignment = .right
        //label.text = "3℃"
        return label
    }()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! WeatherCell
        if (indexPath.row == 0) {
            cell.layer.masksToBounds = true
            cell.layer.shadowColor = UIColor(named: "black")?.cgColor
            cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
        cell.selectionStyle = .none
        cell.dateLabel.text = dayInWeek(NSDate().dayOfWeek() + indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenHeight * 0.1
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if error == nil {
                let array = placeMark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                let city = mark.locality
                let cityPinyin = (city?.transformToPinyin())!
                self.city = String(cityPinyin.prefix(cityPinyin.count-3))
                self.cityLabel.text = self.city
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
}

extension NSDate {
    func dayOfWeek() -> Int {
        let interval = self.timeIntervalSince1970
        let days = Int(interval / 86400)
        let day = (days - 3) % 7
        return day
    }
}

func dayInWeek(_ day: Int) -> String {
    switch day {
    case 1:
        return "Monday"
    case 2:
        return "Tuesday"
    case 3:
        return "Wednesday"
    case 4:
        return "Thursday"
    case 5:
        return "Friday"
    case 6:
        return "Saturday"
    case 0:
        return "Sunday"
    default:
        return "Nav"
    }
}

/// 将中文字符串转换为拼音
///
/// - Parameter hasBlank: 是否带空格（默认不带空格）
extension String {
    func transformToPinyin(hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
}
