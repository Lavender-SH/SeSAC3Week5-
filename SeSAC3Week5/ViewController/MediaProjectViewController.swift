//
//  MediaProjectViewController.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/20.
//

import UIKit
import Alamofire
import Kingfisher

// MARK: - 컬렉션뷰 속성 프로토콜 커스텀
protocol TwoCollectionViewAttributeProtocol{
    func configureCollectionView()
    func setupCollectionView()
}

class MediaProjectViewController: UIViewController {
    
    var similarList: Similar = Similar(page: 0, results: [], totalPages: 0, totalResults: 0)
    var secondVideoList: Video = Video(id: 0, results: [])
    
    var currentData: Similar = Similar(page: 0, results: [], totalPages: 0, totalResults: 0)
    var twoCurrentData: Video = Video(id: 0, results: [])

    
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let flowLayout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupCollectionView()
        dispatchGroupLeave()
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
                
    }
    
    // MARK: - 디스패치큐 그룹화
    func dispatchGroupLeave() {
        let group = DispatchGroup()
        
        group.enter() // +1
        DispatchQueue.global().async(group: group) {
            self.callSimilar(id: 872585) { data in
                self.similarList = data
                print("===1===")
                group.leave() // -1
            }
        }
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.callVideo(id: 872585) { secondValue in
                self.secondVideoList = secondValue
                print("===2===")
                group.leave()
            }
        }
        
        
        group.notify(queue: .main) {
            print("END")
            self.mediaCollectionView.reloadData()
        }
    }
// MARK: - Similar API
    func callSimilar(id: Int, completionHandler: @escaping (Similar) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(APIKey.tmdb)&language=ko-KR"
    
        AF.request(url,method: .get).validate(statusCode: 200...500)
            .responseDecodable(of:Similar.self){ response in
                switch response.result {
                case .success(let value):
                    self.similarList = value
                    print(self.similarList)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
        }
    }
// MARK: - Video API
    func callVideo(id: Int, completionHandler: @escaping (Video) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(APIKey.tmdb)&language=ko-KR"
    
        AF.request(url,method: .get).validate(statusCode: 200...500)
            .responseDecodable(of:Video.self){ response in
                switch response.result {
                case .success(let secondValue):
                    self.secondVideoList = secondValue
                    print(self.secondVideoList)
                    completionHandler(secondValue)
                case .failure(let error):
                    print(error)
                }
        }
    }

// MARK: - 세그먼트를 누를때 인덱스에 따라 값을 다르게 받음
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            currentData = similarList
        } else {
            twoCurrentData = secondVideoList
        }
    }
    
    
    
    
    
    
    
    
    
    
// MARK: - 컬렉션뷰 레이아웃
    func setupCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        mediaCollectionView.collectionViewLayout = layout
    }

}

// MARK: - 컬렉션뷰 셀
extension MediaProjectViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.similarList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaProjectCollectionViewCell", for: indexPath) as? MediaProjectCollectionViewCell else { return UICollectionViewCell() }
        

        let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(similarList.results[indexPath.item].posterPath ?? "")"
        cell.mediaProjectImageView.kf.setImage(with: URL(string: url))
        return cell

    }
}
// MARK: - 컬렉션뷰 필수 프로토콜
extension MediaProjectViewController: TwoCollectionViewAttributeProtocol{
    func configureCollectionView() {
        //Protocol as Type
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        
        mediaCollectionView.register(UINib(nibName: MediaProjectCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MediaProjectCollectionViewCell.identifier)
        
    }
}
