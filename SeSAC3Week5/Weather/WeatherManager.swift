//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/17.
//

import Foundation

import Alamofire
import SwiftyJSON

class WeatherManager{
    
    static let shared = WeatherManager()
    
    func callRequestCodable(success: @escaping (WeatherData) -> Void,failure: @escaping () -> Void ){
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.weatherKey)"
        
        AF.request(url, method: .get).validate(statusCode:200...500).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure()
            }   
            
        }
    }
    
    
    func callRequestJson(completionHandler: @escaping (JSON) -> ()){
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")


                completionHandler(json)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func callRequestString(completionHandler: @escaping (String,String) -> ()){
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.weatherKey)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                let id = json["weather"][0]["id"].intValue
                
                switch id {
                case 800: print("매우 맑음")
                case 801...899: print("구름이 낀 날씨입니다")
                default: print("나머지는 생략..!")
                }
                
                completionHandler("\(temp)도 입니다.","\(humidity)% 입니다")
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

