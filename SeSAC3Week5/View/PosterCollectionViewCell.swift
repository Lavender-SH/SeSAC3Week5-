//
//  PosterCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/16.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.backgroundColor = UIColor.blue
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.backgroundColor = UIColor.clear
    }

}


