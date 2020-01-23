//
//  WeatherModel.swift
//  Weather
//
//  Created by Ryan on 2020/1/21.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation
import HandyJSON

//位置
struct Location: HandyJSON {
    var path: String?
    var timezone_offset: String?
    var timezone: String?
    var country: String?
    var id: String?
    var name: String?
}

//每日天气
struct Daily: HandyJSON {
    var rainfall: String?
    var wind_speed: String?
    var low: String?
    var date:String?
    var humidity: String?
    var high: String?
    var wind_direction: String?
    var code_day: String?
    var text_night: String?
    var text_day: String?
    var precip: String?
    var wind_scale: String?
    var wind_direction_degree: String?
    var code_night: String?
}

//近期天天气结果
struct RecentDaysWeatherResult: HandyJSON {
    var location: Location?
    var daily: [Daily]?
    var last_update: String?
    
}

//近期天天气
struct RecentDaysWeatherModel: HandyJSON {
    var results: [RecentDaysWeatherResult]?
}

//今天天气
struct Now : HandyJSON {
    var text: String?
    var temperature: String?
    var code: String?
    var wind_scale: String?
    var wind_speed: String?
    var pressure: String?
    var wind_direction: String?
    var wind_direction_degree: String?
    var visibility: String?
    var clouds: String?
    var feels_like: String?
    var humidity: String?
    var dew_point: String?
}

//今天天气结果
struct TodayWeatherResult: HandyJSON {
    var location: Location?
    var now: Now?
    var last_update: String?
}

//今天天气
struct TodayWeatherModel: HandyJSON {
    var results: [TodayWeatherResult]?
}

//小时播报
struct Hourly: HandyJSON {
    var time: String?
    var wind_speed: String?
    var temperature: String?
    var text: String?
    var wind_direction: String?
    var humidity: String?
    var code: String?
}

struct LiveWeatherReuslt: HandyJSON {
    var hourly: [Hourly]?
}

//24小时实时天气
struct LiveWeatherModel: HandyJSON {
    var results: [LiveWeatherReuslt]?
}

//实时天气数据
struct LiveData {
    var nowTime: String
    var imageCode: String
    var degree: String
    
    init(time: String = "下午8时", code: String = "0", degree: String = "6") {
        self.nowTime = time
        self.imageCode = code
        self.degree = degree
    }
}

//近期天气数据
struct RecentDayData {
    var imageCode: String
    var highDegree: String
    var lowDegree: String
    var detailText: String
    
    init(code: String = "1", hCode: String = "8", lCode: String = "0", text: String = "今天多云") {
        self.imageCode = code
        self.highDegree = hCode
        self.lowDegree = lCode
        self.detailText = text
    }
}

//今日天气数据
struct TodayData {
    var text: String
    var temperature: String
    var code: String
    var wind_scale: String
    var wind_speed: String
    var pressure: String
    var wind_direction: String
    var wind_direction_degree: String
    var visibility: String
    var clouds: String
    var feels_like: String
    var humidity: String
    var dew_point: String
    
    init(text: String = "多云", temperature: String = "0", code: String = "0", wind_scale: String = "2", wind_speed: String = "8.05", pressure: String = "1018", wind_direction: String = "西北", wind_direction_degree: String = "340", visibility: String = "16.09", clouds: String = "90", feels_like: String = "14", humidity: String = "90", dew_point: String = "-12") {
        self.text = text
        self.temperature = temperature
        self.code = code
        self.wind_scale = wind_scale
        self.wind_speed = wind_speed
        self.pressure = pressure
        self.wind_direction = wind_direction
        self.wind_direction_degree = wind_direction_degree
        self.visibility = visibility
        self.clouds = clouds
        self.feels_like = feels_like
        self.humidity = humidity
        self.dew_point = dew_point
    }
}
