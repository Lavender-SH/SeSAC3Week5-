//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/16.
//

import UIKit

import Alamofire
import Kingfisher


protocol CollectionViewAttributeProtocol{
    func configureCollectionView()
    func configureCollectionViewLayout()
}

class PosterViewController: UIViewController {
    var list: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var secondList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var thirdList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    var fourthList: Recommendation = Recommendation(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    @IBOutlet var posterCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LottoManager.shared.callLotto{bonus,number in
//            print("클로저로 꺼내온 값: \(bonus),\(number)")
//        }
        // 479718 // 범죄도시
        // 157336 -interstellar
        // 13855 추격자
        // 557 -spider-man 스파이더맨
        // 27205 -inception 인셉션
        callRecommendation(id: 671) { data in
            self.list = data
            self.posterCollectionView.reloadData()
        }
        callRecommendation(id: 479718) { data in
            self.secondList = data
            self.posterCollectionView.reloadData()
        }
        callRecommendation(id: 157336) { data in
            self.thirdList = data
            self.posterCollectionView.reloadData()
        }
        callRecommendation(id: 557) { data in
            self.fourthList = data
            self.posterCollectionView.reloadData()
        }

        
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    func callRecommendation(id: Int, completionHandler: @escaping (Recommendation) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(APIKey.tmdb)&language=ko-KR"
        
        AF.request(url,method: .get).validate(statusCode: 200...500)
            .responseDecodable(of:Recommendation.self){ response in
                switch response.result {
                case .success(let value):
                    self.list = value
                    print(self.list)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            
        }
        
            
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAlert(title: "테스트 얼럿", message: "메세지 입니다", button:"배경색 변경"){
            print("저장 버튼을 클릭 했습니다.")
            self.posterCollectionView.backgroundColor = .lightGray
        }
        
    }
    
    func callLotto() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
            }
    }
    
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return section == 0 ? list.results.count : 9
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else if section == 2 {
            return thirdList.results.count
        } else if section == 3 {
            return fourthList.results.count
        } else {
            return 9
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCollectionViewCell", for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(list.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(secondList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 2 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(thirdList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 3 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(fourthList.results[indexPath.item].posterPath ?? "")"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        
        cell.posterImageView.backgroundColor = UIColor(red:CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return cell
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderPosterCollectionReusableView", for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.titleLabel.text = "테스트 섹션"
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
    
}


extension PosterViewController: CollectionViewAttributeProtocol{
    func configureCollectionView() {
        //Protocol as Type
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
        
    }

}


