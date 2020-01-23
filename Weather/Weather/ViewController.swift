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
    
    //近日数据
    var recentDayData: [RecentDayData] = Array<RecentDayData>(repeating: RecentDayData(), count: 10)
    
    //今日数据
    var todayData = TodayData()
    
    //身份数组
    fileprivate let tableViewId = ["firstCell", "secondCell", "thridCell", "fourthCell", "fifthCell"]
    
    //获取城市后提出网络请求获取数据
    fileprivate var city: String? {
        didSet {
            self.locationManager.stopUpdatingLocation()
            let parameter2: Parameters = ["key":"S_1AG0viprcOBXy96","location": self.city!,"language":"zh-Hans","unit":"c", "start":"0","days":"10"]
            Alamofire.request("https://api.seniverse.com/v3/weather/daily.json?", method: .get, parameters: parameter2, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if let obj = JSONDeserializer<RecentDaysWeatherModel>.deserializeFrom(json: json.debugDescription) {
                        let cell = self.detailWeatherView.cellForRow(at: IndexPath(row: 0, section: 0)) as! FirstTableViewCell
                        cell.highTemperatureLabel.text = String(obj.results?[0].daily?[0].high ?? "8")
                        cell.LowTemperatureLabel.text = String(obj.results?[0].daily?[0].low ?? "0")
                        var data = [RecentDayData]()
                        for i in 0..<10 {
                            data.append(RecentDayData(code: obj.results?[0].daily?[i].code_day ?? "0", hCode: obj.results?[0].daily?[i].high ?? "8", lCode: obj.results?[0].daily?[i].low ?? "0", text: obj.results?[0].daily?[i].text_day ?? "多云"))
                        }
                        self.recentDayData = data
                        self.detailWeatherView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: UITableView.RowAnimation.none)
                        self.detailWeatherView.reloadSections(NSIndexSet(index: 3) as IndexSet, with: UITableView.RowAnimation.none)
                    }
                }
            }
            
            let parameter1: Parameters = ["key":"S_1AG0viprcOBXy96", "location": self.city!,"language":"zh-Hans","unit":"c", "start": "0", "hours": "24"]
            Alamofire.request("https://api.seniverse.com/v3/weather/hourly.json?", method: .get, parameters: parameter1, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if let obj = JSONDeserializer<LiveWeatherModel>.deserializeFrom(json: json.debugDescription) {
                        let cell = self.detailWeatherView.cellForRow(at: IndexPath(row: 0, section: 1)) as! SecondTableViewCell
                        var data = [LiveData]()
                        for i in 0..<24 {
                            let str = String(obj.results?[0].hourly?[i].time ?? "2020-01-23T16:00:00+08:00")
                            let startIndex = str.index(str.startIndex, offsetBy: 11)
                            let endIndex = str.index(str.startIndex, offsetBy: 13)
                            let time = String(str[startIndex..<endIndex])
                            let num = Int(time)
                            let timeString = num ?? 0 > 12 ? "下午" + String((num ?? 0) - 12) + "时": "上午" + String(num ?? 0) + "时"
                            if i == 0 {
                                self.currentWeatherDegreeLabel.text = String(obj.results?[0].hourly?[i].temperature ?? "0")
                                self.currentWeatherTextLabel.text = String(obj.results?[0].hourly?[i].text ?? "晴")
                            }
                            data.append(LiveData(time: timeString, code: String(obj.results?[0].hourly?[i].code ?? "0"), degree: String(obj.results?[0].hourly?[i].temperature ?? "0")))
                        }
                        cell.data = data
                        cell.liveWeatherCollectionView.reloadData()
                    }
                }
            }
            
            let parameter3: Parameters = ["key":"S_1AG0viprcOBXy96", "location": self.city!,"language":"zh-Hans","unit":"c"]
            Alamofire.request("https://api.seniverse.com/v3/weather/now.json?", method: .get, parameters: parameter3, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if let obj = JSONDeserializer<TodayWeatherModel>.deserializeFrom(json: json.debugDescription) {
                        self.todayData = TodayData(text: obj.results?[0].now?.text ?? "多云", temperature: obj.results?[0].now?.temperature ?? "0", code: obj.results?[0].now?.code ?? "1", wind_scale: obj.results?[0].now?.wind_scale ?? "1", wind_speed: obj.results?[0].now?.wind_speed ?? "2", pressure: obj.results?[0].now?.pressure ?? "1000", wind_direction: obj.results?[0].now?.wind_direction ?? "西北", wind_direction_degree: obj.results?[0].now?.wind_direction_degree ?? "30", visibility: obj.results?[0].now?.visibility ?? "1", clouds: obj.results?[0].now?.clouds ?? "90", feels_like: obj.results?[0].now?.feels_like ?? "10", humidity: obj.results?[0].now?.humidity ?? "70")
                    }
                    self.detailWeatherView.reloadSections(NSIndexSet(index: 4)  as IndexSet, with: UITableView.RowAnimation.none)
                }
            }
        }
    }
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView(frame: Frame)
        imageView.image = #imageLiteral(resourceName: "default")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth / 2 - 150, y: 40, width: 300, height: 50))
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        label.text = "黄石市"
        label.textAlignment = .center
        return label
    }()
    
    lazy var currentWeatherTextLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth / 2 - 100, y: 80, width: 200, height: 40))
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "中雨"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var currentWeatherDegreeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth / 2 - 100, y: 130, width: 200, height: 80))
        label.font = UIFont.systemFont(ofSize: 88)
        label.text = "8"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    lazy var detailWeatherView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 260, width: ScreenWidth, height: ScreenHeight - 300))
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        //注册5中cell
        tableView.register(FirstTableViewCell.classForCoder(), forCellReuseIdentifier: tableViewId[0])
        tableView.register(SecondTableViewCell.classForCoder(), forCellReuseIdentifier: tableViewId[1])
        tableView.register(ThirdTableViewCell.classForCoder(), forCellReuseIdentifier: tableViewId[2])
        tableView.register(FourthTableViewCell.classForCoder(), forCellReuseIdentifier: tableViewId[3])
         tableView.register(FifthTableViewCell.classForCoder(), forCellReuseIdentifier: tableViewId[4])
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setupView() {
        self.view.addSubview(backImageView)
        self.view.addSubview(cityLabel)
        self.view.addSubview(currentWeatherTextLabel)
        self.view.addSubview(currentWeatherDegreeLabel)
        self.view.addSubview(detailWeatherView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //开启位置请求
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

extension ViewController: CLLocationManagerDelegate {
    //更新位置
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
                self.cityLabel.text = city
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 9
        case 3:
            return 1
        case 4:
            return 4
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId[0], for: indexPath) as! FirstTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId[1], for: indexPath) as! SecondTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId[2], for: indexPath) as! ThirdTableViewCell
            cell.leftDayLabel.text = dayInWeek(NSDate().dayOfWeek() + indexPath.row + 1)
            cell.highTemperatureLabel.text = recentDayData[indexPath.row+1].highDegree
            cell.LowTemperatureLabel.text = recentDayData[indexPath.row+1].lowDegree
            cell.weatherImageView.image = UIImage(named: String(recentDayData[indexPath.row+1].imageCode))
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId[3], for: indexPath) as! FourthTableViewCell
            cell.label.text = "今天：当前\(recentDayData[0].detailText)。预计最高气温\(String(describing: recentDayData[0].highDegree))\n, 最低气温\(String(describing: recentDayData[0].lowDegree))"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewId[4], for: indexPath) as! FifthTableViewCell
            switch indexPath.row {
            case 0:
                cell.leftTopLabel.text = "体感温度"
                cell.leftBottomLabel.text = todayData.feels_like
                cell.rightTopLabel.text = "气压"
                cell.rightBottomLabel.text = todayData.pressure + "百帕"
            case 1:
                cell.leftTopLabel.text = "湿度"
                cell.leftBottomLabel.text = todayData.humidity + "%"
                cell.rightTopLabel.text = "能见度"
                cell.rightBottomLabel.text = todayData.visibility + "公里"
            case 2:
                cell.leftTopLabel.text = "风"
                cell.leftBottomLabel.text = todayData.wind_direction + "  " + todayData.wind_speed + "km/h"
                cell.rightTopLabel.text = "风力等级"
                cell.rightBottomLabel.text = todayData.wind_scale
            default:
                cell.leftTopLabel.text = "云量"
                cell.leftBottomLabel.text = todayData.clouds
                cell.rightTopLabel.text = "露点温度"
                cell.rightBottomLabel.text = todayData.dew_point
            }
            return cell
        }
        //return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 40
        case 1:
            return 100
        case 2:
            return 40
        case 3:
            return 60
        default:
            return 50
        }
    }
}


extension NSDate {
    func dayOfWeek() -> Int {
        let interval = self.timeIntervalSince1970
        let days = Int(interval / 86400)
        return days
    }
}

func dayInWeek(_ day: Int) -> String {
    let day = (day - 3) % 7
    switch day {
    case 1:
        return "星期一"
    case 2:
        return "星期二"
    case 3:
        return "星期三"
    case 4:
        return "星期四"
    case 5:
        return "星期五"
    case 6:
        return "星期六"
    case 0:
        return "星期天"
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
