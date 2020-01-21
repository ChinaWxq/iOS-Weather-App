//
//  WeatherModel.swift
//  Weather
//
//  Created by Ryan on 2020/1/21.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation
import HandyJSON

//位置Model
struct Location: HandyJSON {
    var path: String?
    var timezone_offset: String?
    var timezone: String?
    var country: String?
    var id: String?
    var name: String?
}

//每日天气Model
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

//近3天天气结果Model
struct ThreeDaysWeatherResult: HandyJSON {
    var location: Location?
    var daily: [Daily]?
    var last_update: String?
    
}

//近3天天气Model
struct ThreeDaysWeatherModel: HandyJSON {
    var results: [ThreeDaysWeatherResult]?
}

//今天天气Model
struct Now : HandyJSON {
    var text: String?
    var temperature: String?
    var code: String?
}

//今天天气结果Model
struct TodayWeatherResult: HandyJSON {
    var location: Location?
    var now: Now?
    var last_update: String?
}

//今天天气Model
struct TodayWeatherModel: HandyJSON {
    var results: [TodayWeatherResult]?
}
