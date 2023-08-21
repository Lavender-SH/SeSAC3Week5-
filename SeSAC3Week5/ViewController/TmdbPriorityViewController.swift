//
//  TmdbPriorityViewController.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/21.
//

import UIKit
import Alamofire
import Kingfisher

class TmdbPriorityViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        callRecommendation(id: 872585) { recommendation in
            if let result = recommendation.results.first {
                self.titleLabel.text = result.title
                self.originalTitleLabel.text = result.originalTitle
            }
        }
        
        
    }
    
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(APIKey.tmdb)&language=ko-KR"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: Recommendation.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
