//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/16.
//

import UIKit

import Alamofire

enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

class CodableViewController: UIViewController {
    var resultText = "Apple"

    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var tempLabel: UILabel!
    
    @IBOutlet var humidityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchLottoData()
        
        WeatherManager.shared.callRequestCodable{ data in
            self.tempLabel.text = "\(data.main.temp)"
        }failure: {
            print("show Alert")
        }
        
        
        
        
        WeatherManager.shared.callRequestString{ temp,hum in
            self.humidityLabel.text = hum
            self.tempLabel.text = temp
            
        }
        
        WeatherManager.shared.callRequestJson { json in
            print("JSON!!!")
            print(json)
            
            let temp = json["main"]["temp"].doubleValue - 273.15
            let humidity = json["main"]["humidity"].intValue
            
            self.humidityLabel.text = "\(humidity)"
            self.tempLabel.text = "\(temp)"
        }
        
        
        fetchTranslateData(source: "ko", target: "en", text: "안녕하세요")
       
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        guard let text = dateTextField.text else {return}
        
        do {
            let result = try validateUserIntput(text: text)
            
        }catch{
            print(error)
        }
        
        let example = try! validateUserIntput(text: text)
        let example2 = try? validateUserIntput(text: text)
//
//
//
//        if validateUserIntpu(text: text){
//            print("검색 가능. 네트워크 요청 가능")
//        } else {
//            print("검색 불가")
//        }
    }
    //    func fetchLottoData() {
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
//
//        DispatchQueue.global().async {
//            //1
//            AF.request(url, method: .get).validate()
//                .responseData { response in
//                    guard let value = response.value else { return }
//                    print("responseData:", value)
//
//                    DispatchQueue.main.async {
//                        //레이블에 숫자 출력하기
//                    }
//
//                }
//        }
//
//
//
//        //2
//        AF.request(url, method: .get).validate()
//            .responseString { response in
//                guard let value = response.value else { return }
//                print("responseString:", value)
//            }
//
//        //3
//        AF.request(url, method: .get).validate()
//            .response { response in
//                guard let value = response.value else { return }
//                print("response:", value)
//            }
//
//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: Lotto.self) { response in
//                guard let value = response.value else { return }
//                print("responseDecodable:", value)
//
//
//            }
//
//    }
    
    
    func fetchTranslateData(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500) 
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                print("확인",self.resultText)
                
                self.fetchTranslate(source: "en", target: "ko", text: self.resultText)
                
            }

    }

    
    func fetchTranslate(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                print("최종",self.resultText)
                
          
                
            }

    }
    
    func validateUserIntput(text: String) throws -> Bool {
        
        //빈칸 일 경우
        guard !(text.isEmpty) else {
            print("빈 값")
            throw ValidationError.emptyString
        }
        
        //숫자 아닐 경우
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
        }
        
        //날짜 형식이 아닐 경우
        guard checkDateFormat(text: text) else {
            print("잘못된 날짜 형식")
            throw ValidationError.isNotDate
        }
        
        return true
        
    }
    
    func checkDateFormat(text:String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        let result = format.date(from: text)
        
        return result == nil ? false : true
        
    }
    

}



struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}


struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

