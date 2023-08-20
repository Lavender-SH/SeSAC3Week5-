//
//  MediaProjectCollectionViewCell.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/20.
//

import UIKit

class MediaProjectCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var mediaProjectImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mediaProjectImageView.image = UIImage(systemName: "star.fill")
        //mediaProjectImageView.backgroundColor = UIColor.clear
    }

}
